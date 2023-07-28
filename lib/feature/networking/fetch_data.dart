import 'package:flutter/material.dart';
import 'package:research_and_development/util/extensions.dart';
import 'model/album.dart';
import 'model/user.dart';
import 'remote/manager.dart';

class FetchAlbum extends StatefulWidget {
  @override
  State<FetchAlbum> createState() => _FetchAlbumState();
}

class _FetchAlbumState extends State<FetchAlbum> {
  final albumId = 1;
  late Future<Album> _fetchedAlbum;

  Future<ListUser>? _userDataList;

  @override
  void initState() {
    super.initState();
    _fetchedAlbum = getAlbum(albumId);
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

            /* return ListView.builder(
              itemBuilder: (context, index) {
                final user = dataList[index];

                return Card(
                  elevation: 16.0,
                  color: Colors.lime,
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Column(
                      children: [
                        Text(user.name),
                        Text(user.email),
                        Text(user.phone),
                      ],
                    ),
                  ),
                );
              },
              itemCount: dataList.length,
              scrollDirection: Axis.horizontal,
            ); */

            /* return ListView(
              padding: EdgeInsets.all(16.0),
              scrollDirection: Axis.horizontal,
              children: [
                for (final user in dataList)
                  Card(
                    elevation: 16.0,
                    color: Colors.lime,
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Column(
                        children: [
                          Text(user.name),
                          Text(user.email),
                          Text(user.phone),
                        ],
                      ),
                    ),
                  ),
              ],
            ); */
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
          }  /* else if (!snapshot.hasData || dataList!.isEmpty) {
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
                  Text('Automate fetch album: $albumId'),
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
        ],
      ),
    );
  }
}
