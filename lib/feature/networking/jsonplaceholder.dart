import 'package:flutter/material.dart';
import 'package:research_and_development/util/extensions.dart';
import 'model/album.dart';
import 'model/post.dart';
import 'model/user.dart';
import 'remote/manager.dart';

class JsonPlaceholder extends StatefulWidget {
  @override
  State<JsonPlaceholder> createState() => _JsonPlaceholderState();
}

class _JsonPlaceholderState extends State<JsonPlaceholder> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _albumId = 1;

  late Future<Album> _fetchedAlbum;

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

  Widget _buildCreatePost(BuildContext rootContext) {
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
                  post.title,
                  style: Theme.of(rootContext)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Center(child: SizedBox(height: 16.0)),
              Align(
                alignment: Alignment.center,
                child: Text(
                  '"${post.body}"',
                  style: Theme.of(rootContext)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontStyle: FontStyle.italic),
                ),
              ),
              Center(child: SizedBox(height: 16.0)),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(rootContext).pop();
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
          } */

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: LinearProgressIndicator(),
          );
        },
      ),
    );
  }

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
