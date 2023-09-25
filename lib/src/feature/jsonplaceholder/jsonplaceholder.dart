import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rnd/src/data/repository/jsonplaceholder_repository.dart';

import '../../../res/values/strings.dart';
import '../../model/jsonplaceholder/album.dart';
import '../../model/jsonplaceholder/post.dart';
import '../../model/jsonplaceholder/user.dart';
import '../../utils/extensions.dart';

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
  const JsonPlaceholder({super.key});

  @override
  State<JsonPlaceholder> createState() => _JsonPlaceholderState();
}

class _JsonPlaceholderState extends State<JsonPlaceholder> {
  // https://docs.flutter.dev/cookbook/forms/retrieve-input
  final _repository = JsonPlaceholderRepository();
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
    _fetchedAlbum = _repository.getAlbum(_albumId);
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(Strings.postedExclamation),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('id: ${post.id}'),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('userId: ${post.userId}'),
              ),
              const Center(child: SizedBox(height: 16.0)),
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
              const Center(child: SizedBox(height: 16.0)),
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
              const Center(child: SizedBox(height: 16.0)),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text(Strings.dismiss),
                ),
              )
            ],
          );
        } else if (snapshot.hasError) {
          return Wrap(
            children: [
              const Center(child: Text(Strings.postingFailed)),
              const Center(
                child: SizedBox(
                  height: 16.0,
                ),
              ),
              const Center(child: Text('😭')),
              const Center(
                child: SizedBox(
                  height: 16.0,
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    print('retry posting clicked');
                  },
                  child: const Text(Strings.retry),
                ),
              )
            ],
          );
        }

        return const Wrap(
          children: [
            Center(child: Text(Strings.postingLoading)),
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
                labelText: Strings.labelTitleForm,
                labelStyle: TextStyle(color: Colors.purple.shade900),
                floatingLabelAlignment: FloatingLabelAlignment.center,
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            const SizedBox(height: 16.0),
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
                labelText: Strings.labelThoughtForm,
                labelStyle: TextStyle(color: Colors.purple.shade900),
                floatingLabelAlignment: FloatingLabelAlignment.center,
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            const SizedBox(
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
                    _createPost = _repository.createPost(
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
                child: const Icon(Icons.send),
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
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (context, index) {
                  final user = dataList[index];

                  return Container(
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.all(8.0),
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

          return const Padding(
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
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _userDataList = _repository.getListUser();
            });
          },
          child: const Text(Strings.getUserDataList),
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
                  const SizedBox(height: 16.0),
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
                  Text(Strings.automateFetchAlbum(_albumId)),
                  const SizedBox(width: 16.0),
                  const CircularProgressIndicator(),
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
        title: const Text(
          Strings.jsonPlaceholder,
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
