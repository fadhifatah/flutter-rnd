import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../model/news/article.dart';

abstract class TopHeadlinesState extends Equatable {
  final List<Article> articles;
  final bool isLastPage;
  final int? nextPage;
  final DioException? exception;

  const TopHeadlinesState({
    this.articles = const [],
    this.isLastPage = false,
    this.nextPage,
    this.exception,
  });

  @override
  List<Object?> get props => [articles, isLastPage, exception];
}

class Loading extends TopHeadlinesState {
  const Loading();
}

class Content extends TopHeadlinesState {
  const Content({super.articles, super.isLastPage, super.nextPage});
}

class Failed extends TopHeadlinesState {
  const Failed({super.exception});
}
