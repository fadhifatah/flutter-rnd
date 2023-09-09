import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../converter/saved_headlines_converter.dart';
import '../dao/saved_headlines_dao.dart';
import '../entity/saved_headlines_entity.dart';

part 'news_database.g.dart';

@Database(version: 1, entities: [SavedHeadlinesEntity])
@TypeConverters([SourceConverter, ArticleConverter])
abstract class NewsDatabase extends FloorDatabase {
  SavedHeadlinesDao get topHeadlinesDao;
}
