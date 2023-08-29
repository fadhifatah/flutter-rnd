import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:research_and_development/support/extensions.dart';

import 'album.dart';
import 'post.dart';
import 'user.dart';

/// Example of simple networking using https://jsonplaceholder.typicode.com/.
/// This example is using basic networking using [http] package.
/// This feature has [model] and [remote] package.
///
/// [model] is a kind of dto to store each of object properties, it also use
/// basic serialization and deserialization.
///
/// [remote] contains data manager that store call request and config utility
/// to support it.
class JsonPlaceholder extends StatefulWidget {
  @override
  State<JsonPlaceholder> createState() => _JsonPlaceholderState();
}

class _JsonPlaceholderState extends State<JsonPlaceholder> {
  // https://docs.flutter.dev/cookbook/forms/retrieve-input
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _albumId = 1;

  // https://docs.flutter.dev/cookbook/networking/fetch-data
  late Future<Album> _fetchedAlbum;

  // https://docs.flutter.dev/cookbook/networking/send-data
  Future<ListUser>? _userDataList;
  Future<Post>? _createPost;

  @override
  void dispose() {
    _bodyController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchedAlbum = getAlbum(_albumId);
  }

  Future<Album> getAlbum(int id) async {
    await Future.delayed(Duration(seconds: 5));

    final response = await http.get(
      Uri.parse('${Config.baseUrl}albums/$id'),
      headers: {
        HttpHeaders.authorizationHeader: Config.apiKey,
      },
    );

    if (response.statusCode == 200) {
      // OK response
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get album');
    }
  }

  Future<Post> createPost(Post post) async {
    print('createPost internal ${jsonEncode(post.toJson())}');

    final response = await http.post(
      Uri.parse('${Config.baseUrl}posts'),
      body: jsonEncode(post.toJson()),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get post datalist');
    }
  }

  Future<ListUser> getListUser() async {
    await Future.delayed(Duration(seconds: 5));

    final response = await http.get(Uri.parse('${Config.baseUrl}users'));

    print('getListUser response code: ${response.statusCode}');

    if (response.statusCode == 200) {
      return ListUser.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get user data list');
    }
  }

  /// FutureBuilder observe future object to get the snapshot that contains
  /// data of response body. It must returns Widget which correspond with
  /// snapshot and/or any response state available.
  Widget _buildCreatePost(BuildContext dialogContext) {
    return FutureBuilder(
      builder: (context, snapshot) {
        print('_buildCreatePost connection_state: ${snapshot.connectionState}');
        if (snapshot.hasData) {
          final post = snapshot.data!;

          return Wrap(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Posted!'),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('id: ${post.id}'),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('userId: ${post.userId}'),
              ),
              Center(child: SizedBox(height: 16.0)),
              Align(
                alignment: Alignment.center,
                child: Text(
                  post.title.isEmpty ? 'EMPTY' : post.title,
                  style: Theme.of(dialogContext)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Center(child: SizedBox(height: 16.0)),
              Align(
                alignment: Alignment.center,
                child: Text(
                  post.body.isEmpty ? 'EMPTY' : '"${post.body}"',
                  style: Theme.of(dialogContext)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontStyle: FontStyle.italic),
                ),
              ),
              Center(child: SizedBox(height: 16.0)),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: Text('Dismiss'),
                ),
              )
            ],
          );
        } else if (snapshot.hasError) {
          return Wrap(
            children: [
              Center(child: Text('Posting failed :(')),
              Center(
                child: SizedBox(
                  height: 16.0,
                ),
              ),
              Center(child: Text('😭')),
              Center(
                child: SizedBox(
                  height: 16.0,
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    print('retry posting clicked');
                  },
                  child: Text('Retry'),
                ),
              )
            ],
          );
        }

        return Wrap(
          children: [
            Center(child: Text('Posting...')),
            Center(
              child: SizedBox(
                height: 16.0,
              ),
            ),
            Center(child: LinearProgressIndicator()),
          ],
        );
      },
      future: _createPost,
    );
  }

  /// Function to generate Create Post example. It contains two TextField and a
  /// ElevatedButton to send post request and display a Dialog.
  Widget _fieldCreatePost() {
    return Container(
      color: Colors.purple.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              cursorColor: Colors.purple.shade900,
              controller: _titleController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple.shade900)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple.shade900)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple.shade900)),
                labelText: 'Your title, please!',
                labelStyle: TextStyle(color: Colors.purple.shade900),
                floatingLabelAlignment: FloatingLabelAlignment.center,
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              cursorColor: Colors.purple.shade900,
              controller: _bodyController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple.shade900)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple.shade900)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple.shade900)),
                labelText: 'What\'s on your thought?',
                labelStyle: TextStyle(color: Colors.purple.shade900),
                floatingLabelAlignment: FloatingLabelAlignment.center,
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  print('_fieldCreatePost button clicked');
                  print(
                      'title: ${_titleController.text}; body: ${_bodyController.text}');

                  setState(() {
                    _createPost = createPost(
                      Post(
                          userId: 1,
                          id: 0,
                          title: _titleController.text,
                          body: _bodyController.text),
                    );
                  });

                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: _buildCreatePost(context),
                        ),
                      );
                    },
                  );
                },
                child: Icon(Icons.send),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// FutureBuilder to handle [_userDataList]
  Widget _buildUserDataList() {
    return Container(
      color: Colors.lightBlue,
      child: FutureBuilder(
        future: _userDataList,
        builder: (context, snapshot) {
          print(
              '_buildUserDataList connection state: ${snapshot.connectionState}');

          // var dataList = snapshot.data?.dataList;

          if (snapshot.hasData) {
            var dataList = snapshot.data!.dataList;

            return SizedBox(
              height: 250,
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemBuilder: (context, index) {
                  final user = dataList[index];

                  return Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 150,
                      child: Card(
                        elevation: 16.0,
                        color: Colors.yellow,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Wrap(
                            runSpacing: 16.0,
                            children: [
                              Text(user.name),
                              Text(user.email),
                              Text(user.phone),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: dataList.length,
                scrollDirection: Axis.horizontal,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error!',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.red.shade900),
                ),
              ),
            );
          } /* else if (!snapshot.hasData || dataList!.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Empty!',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.red.shade900),
                ),
              ),
            );
          } */ // Experiment with snapshot properties and possible state

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: LinearProgressIndicator(),
          );
        },
      ),
    );
  }

  /// Function to generate action button to trigger [_userDataList] when pressed
  Widget _buttonUserDataList() {
    return Container(
      color: Colors.lightBlue,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _userDataList = getListUser();
            });
          },
          child: Text('Get user data list!'),
        ),
      ),
    );
  }

  /// FutureBuilder to handle [_fetchedAlbum]. This is a basic lesson
  Widget _buildFetchAlbum() {
    return Container(
      color: Colors.amber,
      child: FutureBuilder(
        future: _fetchedAlbum,
        builder: (context, snapshot) {
          print(
              '_buildFetchAlbum connection_state: ${snapshot.connectionState}');
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Introducing, ${snapshot.data!.title.asTitleCase}.',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                      'Fetched with id: ${snapshot.data!.id} from userId: ${snapshot.data!.userId}')
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error!',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.red.shade900),
                ),
              ),
            );
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Automate fetch album: $_albumId'),
                  SizedBox(width: 16.0),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'JSONPlaceholder',
        ),
      ),
      body: ListView(
        children: [
          _buildFetchAlbum(),
          (_userDataList == null)
              ? _buttonUserDataList()
              : _buildUserDataList(),
          _fieldCreatePost(),
        ],
      ),
    );
  }
}

abstract class Config {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/';
  static const String apiKey = 'MY_API_KEY';
}
