import 'package:favoritos_youtube/api/api.dart';

abstract class YTEndPoints {
  static String loadVideosBySearch(String search) {
    return 'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$kAPIKEY&maxResults=10';
  }

  static String suggestedVideosBySearch(String search) {
    return 'http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json';
  }
}

// "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"
// "http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"
// "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"

// https://www.googleapis.com/youtube/v3/search?part=snippet&q=teste&type=video&key=AIzaSyAMMO0Ys7vu2Cf7llg_ecBhr2SwOg1L18w&maxResults=10
