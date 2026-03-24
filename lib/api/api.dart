import 'dart:convert';
import 'package:favoritos_youtube/api/yt_endpoints.dart';
import 'package:favoritos_youtube/models/video.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final String? kAPIKEY = dotenv.env['API_KEY'];

class API {
  String _search = '';
  String _nextToken = '';

  Future<List<Video>> search(String search) async {
    _search = search;
    http.Response response = await http.get(Uri.parse(YTEndPoints.loadVideosBySearch(search)));
    return decode(response);
  }

  Future<List<Video>> nextPage() async {
    http.Response response = await http.get(Uri.parse(YTEndPoints.nextPage(_search, _nextToken)));
    return decode(response);
  }

  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      _nextToken = decoded['nextPageToken'] ?? '';
      List<Video> videos = decoded['items'].map<Video>((map) => Video.fromJson(map)).toList();
      return videos;
    } else {
      throw Exception('Falha ao carregar videos');
    }
  }
}
