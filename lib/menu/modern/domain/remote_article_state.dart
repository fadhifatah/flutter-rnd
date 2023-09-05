import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../model/article.dart';

abstract class RemoteArticleState extends Equatable {
  final List<Article> articles;
  final bool isLastPage;
  final DioException? exception;

  const RemoteArticleState({
    this.articles = const [],
    this.isLastPage = false,
    this.exception,
  });

  @override
  List<Object?> get props => [articles, isLastPage, exception];
}

class RemoteArticleLoading extends RemoteArticleState {
  const RemoteArticleLoading();
}

class RemoteArticleContent extends RemoteArticleState {
  const RemoteArticleContent({super.articles, super.isLastPage});
}

class RemoteArticleFailed extends RemoteArticleState {
  const RemoteArticleFailed({super.exception});
}
