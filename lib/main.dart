import 'package:favoritos_youtube/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(FavoritosYoutube());
}

class FavoritosYoutube extends StatelessWidget {
  const FavoritosYoutube({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favoritos Youtube',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black87,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white,
        ),
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
