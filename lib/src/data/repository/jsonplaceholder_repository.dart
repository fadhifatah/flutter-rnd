import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../res/values/configs.dart';
import '../../model/jsonplaceholder/album.dart';
import '../../model/jsonplaceholder/post.dart';
import '../../model/jsonplaceholder/user.dart';
class JsonPlaceholderRepository {
  Future<Album> getAlbum(int id) async {
    await Future.delayed(const Duration(seconds: 5));

    final response = await http.get(
      Uri.parse('${Configuration.jsonplaceholderBaseUrl}albums/$id'),
      headers: {
        HttpHeaders.authorizationHeader: Configuration.jsonplaceholderApiKey,
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
      Uri.parse('${Configuration.jsonplaceholderBaseUrl}posts'),
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
    await Future.delayed(const Duration(seconds: 5));

    final response = await http
        .get(Uri.parse('${Configuration.jsonplaceholderBaseUrl}users'));

    print('getListUser response code: ${response.statusCode}');

    if (response.statusCode == 200) {
      return ListUser.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get user data list');
    }
  }
}