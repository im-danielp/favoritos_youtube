import 'dart:convert';
import 'package:favoritos_youtube/api/yt_endpoints.dart';
import 'package:favoritos_youtube/models/video.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_explode_dart/youtube_explode_dart.dart' show YoutubeExplode, ChannelId;

final String? kAPIKEY = dotenv.env['API_KEY'];

class API {
  String _search = '';
  String _nextToken = '';

  final Map<String, String> _channelLogoCache = {};
  final _yt = YoutubeExplode();

  Future<List<Video>> search(String search) async {
    _search = search;
    http.Response response = await http.get(Uri.parse(YTEndPoints.loadVideosBySearch(search)));
    return decode(response);
  }

  Future<List<Video>> nextPage() async {
    http.Response response = await http.get(Uri.parse(YTEndPoints.nextPage(_search, _nextToken)));
    return decode(response);
  }

  Future<String> getChannelLogo(String channelId) async {
    if (_channelLogoCache.containsKey(channelId)) {
      return _channelLogoCache[channelId]!;
    }

    final channel = await _yt.channels.get(ChannelId(channelId));
    _channelLogoCache[channelId] = channel.logoUrl;
    return channel.logoUrl;
  }

  Future<List<Video>> decode(http.Response response) async {
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      _nextToken = decoded['nextPageToken'] ?? '';

      List<Video> videos = await Future.wait(
        decoded['items'].map<Future<Video>>((map) async {
          map['channelLogo'] = await getChannelLogo(map['snippet']['channelId']);
          return Video.fromJson(map);
        }).toList(),
      );

      return videos;
    } else {
      throw Exception('Falha ao carregar videos');
    }
  }
}
