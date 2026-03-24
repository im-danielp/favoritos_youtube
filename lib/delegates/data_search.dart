import 'dart:convert';
import 'package:favoritos_youtube/api/yt_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataSearch extends SearchDelegate<String?> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.black,
      textTheme: const TextTheme(titleLarge: TextStyle(color: Colors.white, fontSize: 18)),
      textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white54),
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((_) {
      if (context.mounted) close(context, query);
    });
    return Container(color: Colors.blue);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return SizedBox.shrink();
    } else {
      return FutureBuilder<List<String>>(
        future: suggestions(query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) => ListTile(
                title: Text(snapshot.data![index]),
                leading: Icon(Icons.search),
                textColor: Colors.white,
                iconColor: Colors.white,
                onTap: () => close(context, snapshot.data![index]),
              ),
            );
          }
        },
      );
    }
  }

  Future<List<String>> suggestions(String search) async {
    final response = await http.get(Uri.parse(YTEndPoints.suggestedVideosBySearch(search)));

    if (response.statusCode == 200) {
      final List decoded = jsonDecode(response.body);
      final List suggestionsRaw = decoded[1];
      return suggestionsRaw.map((v) => v[0].toString()).toList();
    } else {
      throw Exception('Falha ao carregar sugestões');
    }
  }
}
