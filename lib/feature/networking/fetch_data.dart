import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:research_and_development/feature/networking/model/album.dart';
import 'package:http/http.dart' as http;
import 'package:research_and_development/util/extensions.dart';

Future<Album> getAlbum(int id) async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'));

  if (response.statusCode == 200) {
    // OK response
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to get album');
  }
}

class FetchAlbum extends StatefulWidget {
  @override
  State<FetchAlbum> createState() => _FetchAlbumState();
}

class _FetchAlbumState extends State<FetchAlbum> {
  late Future<Album> fetchedAlbum;
  @override
  void initState() {
    super.initState();
    fetchedAlbum = getAlbum(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fetch Album',
        ),
      ),
      body: FutureBuilder(
        future: fetchedAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Introducing, ${snapshot.data!.title.asTitleCase}.',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                      'Fetched with id: ${snapshot.data!.id} from user: ${snapshot.data!.userId}')
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error!'),
            );
          }

          return Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
