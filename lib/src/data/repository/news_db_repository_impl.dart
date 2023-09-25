import 'package:flutter_rnd/src/data/local/floor/entity/saved_headlines_entity.dart';
import 'package:flutter_rnd/src/model/news/article.dart';

import '../local/floor/dao/saved_headlines_dao.dart';
import 'news_db_repository.dart';

class NewsDbRepositoryImpl implements NewsDbRepository {
  final SavedHeadlinesDao _savedHeadlinesDao;

  NewsDbRepositoryImpl(this._savedHeadlinesDao);

  @override
  Future<void> delete(Article article) async {
    return _savedHeadlinesDao.remove(article.asEntity);
  }

  @override
  Future<List<Article>> getList() {
    return _savedHeadlinesDao
        .getList()
        .then((value) => value.map((item) => item.asModel).toList());
  }

  @override
  Future<void> save(Article article) {
    return _savedHeadlinesDao.insert(article.asEntity);
  }
}
