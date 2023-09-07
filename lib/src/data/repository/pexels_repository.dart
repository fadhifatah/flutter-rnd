import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../res/values/configs.dart';
import '../../model/pexels/photo.dart';
import '../remote/dto/response/photo_response.dart';

class PexelsRepository {
  

Future<void> getCuratedPexels(
  int pageIndex,
  int pageItemSize,
  PagingController<int, Photo> pagingController,
) async {
  try {
    print('getCuratedPexels page: $pageIndex');

    final response = await http.get(
      Uri.parse(
          '${Configuration.pexelsBaseUrl}curated?page=$pageIndex&per_page=$pageItemSize'),
      headers: {
        HttpHeaders.authorizationHeader: Configuration.pexelsApiKey,
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
          '${Configuration.pexelsBaseUrl}search?query=$query&page=$pageIndex&per_page=$pageItemSize'),
      headers: {
        HttpHeaders.authorizationHeader: Configuration.pexelsApiKey,
      },
    );

    print('getSearchPexels statusCode: ${response.statusCode}');
    if (response.statusCode == HttpStatus.ok) {
      final photoResponse = PhotoResponse.fromJson(jsonDecode(response.body));
      final photoList = photoResponse.photos;
      final isLastPage = photoList.length < photoResponse.perPage;

      if (isLastPage) {
        pagingController.appendLastPage(photoList);
      } else {
        pagingController.appendPage(photoList, pageIndex + 1);
      }
    } else if (response.statusCode == HttpStatus.badRequest) {
      pagingController.appendLastPage([]);
    }
  } on Exception catch (error) {
    pagingController.error = error;
  } on Error {
    pagingController.error = Exception('Error occured!');
  }
}
}