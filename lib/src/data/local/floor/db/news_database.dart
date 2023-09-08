import 'package:floor/floor.dart';

import '../converter/top_headlines_converter.dart';
import '../dao/top_headlines_dao.dart';
import '../entity/top_headlines_entity.dart';

part 'news_database.g.dart';

@Database(version: 1, entities: [TopHeadlinesEntity])
@TypeConverters([SourceConverter, ArticleConverter])
abstract class NewsDatabase extends FloorDatabase {
  TopHeadlinesDao get topHeadlinesDao;
}
