import 'dart:async';
import 'dart:convert';

import 'package:favoritos_youtube/models/video.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc implements BlocBase<Map<String, Video>> {
  Map<String, Video> _favorites = {};

  final _favController = BehaviorSubject<Map<String, Video>>.seeded({});
  Stream<Map<String, Video>> get outFav => _favController.stream;

  FavoriteBloc() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.containsKey('favorites')) {
        final favoritesString = prefs.getString('favorites');
        if (favoritesString != null && favoritesString.isNotEmpty) {
          _favorites = jsonDecode(favoritesString).map((k, v) {
            return MapEntry(k, Video.fromJson(v));
          }).cast<String, Video>();

          _favController.add(Map.of(_favorites));
        }
      }
    });
  }

  void toggleFavorite(Video video) {
    if (_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      _favorites[video.id] = video;
    }
    _favController.add(Map.of(_favorites));
    _saveFav();
  }

  void _saveFav() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('favorites', jsonEncode(_favorites));
    });
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {}

  @override
  Future<void> close() => _favController.close();

  @override
  void emit(Map<String, Video> state) => _favController.add(state);

  @override
  bool get isClosed => _favController.isClosed;

  @override
  void onChange(Change<Map<String, Video>> change) {}

  @override
  void onError(Object error, StackTrace stackTrace) {}

  @override
  Map<String, Video> get state => _favController.value;

  @override
  Stream<Map<String, Video>> get stream => _favController.stream;
}
