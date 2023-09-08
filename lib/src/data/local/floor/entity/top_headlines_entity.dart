import 'package:floor/floor.dart';

import '../../../../model/news/article.dart';

@entity
class TopHeadlinesEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final Article? article;

  const TopHeadlinesEntity({
    this.id,
    this.article,
  });
}
