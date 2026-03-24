import 'dart:async';
import 'package:favoritos_youtube/api/api.dart';
import 'package:favoritos_youtube/models/video.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideosBloc implements BlocBase {
  late API api;
  List<Video> videos = [];

  final _videosController = StreamController<List<Video>>.broadcast();
  Stream<List<Video>> get outVideos => _videosController.stream;

  final _searchController = StreamController<String>();
  Sink<String> get inSearch => _searchController.sink;

  VideosBloc() {
    api = API();
    _searchController.stream.listen(_search);
  }

  void _search(String search) async {
    if (search != '') {
      _videosController.sink.add([]);
      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }
    _videosController.sink.add(videos);
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    // TODO: implement addError
  }

  @override
  Future<void> close() {
    // TODO: implement close
    throw UnimplementedError();
  }

  @override
  void emit(state) {
    // TODO: implement emit
  }

  @override
  bool get isClosed => _videosController.isClosed;

  @override
  void onChange(Change<dynamic> change) {
    // TODO: implement onChange
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // TODO: implement onError
  }

  @override
  // TODO: implement state
  get state => throw UnimplementedError();

  @override
  Stream<dynamic> get stream => outVideos;
}
