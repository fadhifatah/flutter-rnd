import '../../model/news/article.dart';

abstract class NewsDbRepository {
  Future<void> save(Article article);

  Future<List<Article>> getList();

  Future<void> delete(Article article);
}
