import 'package:equatable/equatable.dart';

import '../../../model/news/article.dart';

abstract class SavedHeadlinesState extends Equatable {
  final List<Article> dataList;

  const SavedHeadlinesState({this.dataList = const []});

  @override
  List<Object?> get props => [dataList];
}

class Loading extends SavedHeadlinesState {
  const Loading();
}

class Success extends SavedHeadlinesState {
  const Success({super.dataList});
}
