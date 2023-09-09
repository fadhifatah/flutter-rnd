import 'package:floor/floor.dart';

import '../../../../model/news/article.dart';

@entity
class SavedHeadlinesEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final Article? article;

  const SavedHeadlinesEntity({
    this.id,
    this.article,
  });
}

extension ToEntity on Article {
  SavedHeadlinesEntity get asEntity => SavedHeadlinesEntity(article: this);
}

extension ToModel on SavedHeadlinesEntity {
  Article get asModel => Article(
        source: article?.source,
        author: article?.author,
        title: article?.title,
        description: article?.description,
        url: article?.url,
        urlToImage: article?.urlToImage,
        publishedAt: article?.publishedAt,
        content: article?.content,
      );
}
