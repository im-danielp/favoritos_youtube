import 'dart:developer';

import 'package:favoritos_youtube/delegates/data_search.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(height: 40, child: Image.asset('images/youtube_logo.png')),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: [
          Text('0'),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final result = await showSearch(context: context, delegate: DataSearch());
              log(result.toString());
            },
          ),
        ],
      ),
      body: SizedBox(),
    );
  }
}
