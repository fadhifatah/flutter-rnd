import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/album.dart';
import '../model/post.dart';
import '../model/user.dart';
import 'config.dart';

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
