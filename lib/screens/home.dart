import 'package:favoritos_youtube/blocs/videos_bloc.dart';
import 'package:favoritos_youtube/delegates/data_search.dart';
import 'package:favoritos_youtube/widgets/video_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final videoBloc = BlocProvider.of<VideosBloc>(context);

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
              if (result != null && context.mounted) videoBloc.inSearch.add(result);
            },
          ),
        ],
      ),
      body: StreamBuilder<List>(
        initialData: [],
        stream: videoBloc.outVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length + 1,
              itemBuilder: (context, index) {
                if (index < snapshot.data!.length) {
                  return VideoTile(video: snapshot.data![index]);
                } else if (index > 1) {
                  videoBloc.inSearch.add('');
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: .center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.red),
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
