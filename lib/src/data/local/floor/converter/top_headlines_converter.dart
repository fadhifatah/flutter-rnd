import 'dart:convert';

import 'package:floor/floor.dart';

import '../../../../model/news/article.dart';
import '../../../../model/news/source.dart';

class ArticleConverter extends TypeConverter<Article?, String?> {
  @override
  Article? decode(String? databaseValue) {
    if (databaseValue == null || databaseValue.isEmpty) return null;
    return Article.fromJson(json.decode(databaseValue));
  }

  @override
  String? encode(Article? value) {
    return json.encode(value);
  }
}

class SourceConverter extends TypeConverter<Source?, String?> {
  @override
  Source? decode(String? databaseValue) {
    if (databaseValue == null || databaseValue.isEmpty) return null;
    return Source.fromJson(json.decode(databaseValue));
  }

  @override
  String? encode(Source? value) {
    return json.encode(value);
  }
}
