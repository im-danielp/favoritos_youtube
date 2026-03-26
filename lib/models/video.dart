class Video {
  final String id;
  final String title;
  final String thumb;
  final String channel;
  final String channelLogo;

  Video({
    required this.id,
    required this.title,
    required this.thumb,
    required this.channel,
    required this.channelLogo,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('snippet')) {
      return Video(
        id: json['id']['videoId'] ?? '',
        title: json['snippet']['title'] ?? '',
        thumb: json['snippet']['thumbnails']['high']['url'] ?? '',
        channel: json['snippet']['channelTitle'] ?? '',
        channelLogo: json['channelLogo'] ?? '',
      );
    } else {
      return Video(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        thumb: json['thumb'] ?? '',
        channel: json['channel'] ?? '',
        channelLogo: json['channelLogo'] ?? '',
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumb': thumb,
      'channel': channel,
      'channelLogo': channelLogo,
    };
  }
}
