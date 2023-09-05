import '../config/configuration.dart';
import '../data/data_state.dart';
import '../data/dto/request/top_headlines_request.dart';
import '../data/repository/api_repository.dart';
import 'base_cubit.dart';
import 'remote_article_state.dart';

class RemoteArtibleCubit extends BaseCubit<RemoteArticleState> {
  final ApiRepository _apiRepository;

  RemoteArtibleCubit(this._apiRepository) : super(const RemoteArticleLoading());

  Future<void> fetchTopHeadlines(int page, {String? keyword}) async {
    if (isBusy) return;

    await run(() async {
      final response = await _apiRepository.fetchTopHeadlines(
          request: TopHeadlinesRequest(page: page, keyword: keyword));

      if (response is DataSuccess) {
        final articles = response.data?.articles ?? [];
        final isLastPage = articles.length < Configuration.pageSizeDefault;

        emit(RemoteArticleContent(articles: articles, isLastPage: isLastPage));
      } else {
        emit(RemoteArticleFailed(exception: response.exception));
      }
    });
  }
}
