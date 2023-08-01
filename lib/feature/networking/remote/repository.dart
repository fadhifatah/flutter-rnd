import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:research_and_development/feature/networking/model/photo.dart';
import '../model/album.dart';
import '../model/post.dart';
import '../model/user.dart';
import 'remote.dart';

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

Future<void> getCuratedPexels(
  int pageIndex,
  int pageItemSize,
  PagingController<int, Photo> pagingController,
) async {
  try {
    print('getCuratedPexels page: $pageIndex');

    final response = await http.get(
      Uri.parse(
          '${Config.pexelsUrl}curated?page=$pageIndex&per_page=$pageItemSize'),
      headers: {
        HttpHeaders.authorizationHeader: Config.pexelsKey,
      },
    );

    final photoResponse = PhotoResponse.fromJson(jsonDecode(response.body));
    final photoList = photoResponse.photos;
    final isLastPage = photoList.length < photoResponse.perPage;

    if (isLastPage) {
      pagingController.appendLastPage(photoList);
    } else {
      pagingController.appendPage(photoList, pageIndex + 1);
    }
  } on Exception catch (error) {
    pagingController.error = error;
  } on Error {
    pagingController.error = Exception('Error occured!');
  }
}

Future<void> getSearchPexels(
  String query,
  int pageIndex,
  int pageItemSize,
  PagingController<int, Photo> pagingController,
) async {
  try {
    print('getSearchPexels query: $query page: $pageIndex');

    final response = await http.get(
      Uri.parse(
          '${Config.pexelsUrl}search?query=$query&page=$pageIndex&per_page=$pageItemSize'),
      headers: {
        HttpHeaders.authorizationHeader: Config.pexelsKey,
      },
    );

    print('getSearchPexels statusCode: ${response.statusCode}');
    if (response.statusCode == 200) {
      final photoResponse = PhotoResponse.fromJson(jsonDecode(response.body));
      final photoList = photoResponse.photos;
      final isLastPage = photoList.length < photoResponse.perPage;

      if (isLastPage) {
        pagingController.appendLastPage(photoList);
      } else {
        pagingController.appendPage(photoList, pageIndex + 1);
      }
    } else if (response.statusCode == 400) {
      pagingController.appendLastPage([]);
    }
  } on Exception catch (error) {
    pagingController.error = error;
  } on Error {
    pagingController.error = Exception('Error occured!');
  }
}
