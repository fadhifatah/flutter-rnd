import 'package:json_annotation/json_annotation.dart';

import '../../../../model/news/article.dart';

part 'top_headlines_response.g.dart';

@JsonSerializable()
class TopHeadlinesResponse {
  final String status;
  final int totalResults;
  final List<Article> articles;

  TopHeadlinesResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  TopHeadlinesResponse copyWith({
    String? status,
    int? totalResults,
    List<Article>? articles,
  }) =>
      TopHeadlinesResponse(
        status: status ?? this.status,
        totalResults: totalResults ?? this.totalResults,
        articles: articles ?? this.articles,
      );

  factory TopHeadlinesResponse.fromJson(Map<String, dynamic> json) =>
      _$TopHeadlinesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TopHeadlinesResponseToJson(this);
}
