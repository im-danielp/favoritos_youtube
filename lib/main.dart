import 'package:favoritos_youtube/blocs/videos_bloc.dart';
import 'package:favoritos_youtube/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(FavoritosYoutube());
}

class FavoritosYoutube extends StatelessWidget {
  const FavoritosYoutube({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideosBloc(),
      child: MaterialApp(
        title: 'Favoritos Youtube',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black87,
          textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.black87,
            foregroundColor: Colors.white,
          ),
        ),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
