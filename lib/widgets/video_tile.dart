import 'package:favoritos_youtube/models/video.dart';
import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {
  final Video video;

  const VideoTile({
    super.key,
    required this.video,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              video.thumb,
              fit: .cover,
            ),
          ),
          Row(
            crossAxisAlignment: .start,
            spacing: 8,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 8, 0),
                child: CircleAvatar(backgroundColor: Colors.grey),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        video.title,
                        maxLines: 2,
                        overflow: .ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        video.channel,
                        style: TextStyle(fontSize: 12, color: Colors.white60),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.star_border),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
