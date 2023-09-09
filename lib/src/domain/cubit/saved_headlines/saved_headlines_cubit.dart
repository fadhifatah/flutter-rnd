import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/news_db_repository.dart';
import '../../../model/news/article.dart';
import 'saved_headlines_state.dart';

class SavedHeadlinesCubit extends Cubit<SavedHeadlinesState> {
  final NewsDbRepository _dbRepository;

  SavedHeadlinesCubit(this._dbRepository) : super(const Loading());

  Future<void> saveArticle(Article article) async {
    await _dbRepository.save(article);
    emit(await _getSavedHeadlines());
  }

  Future<void> deleteArticle(Article article) async {
    await _dbRepository.delete(article);
    emit(await _getSavedHeadlines());
  }

  Future<void> getSavedHeadlines() async {
    emit(await _getSavedHeadlines());
  }

  Future<SavedHeadlinesState> _getSavedHeadlines() async {
    final result = await _dbRepository.getList();
    return Success(dataList: result);
  }
}
