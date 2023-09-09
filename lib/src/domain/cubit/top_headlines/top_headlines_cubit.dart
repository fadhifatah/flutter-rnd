import '../../../../res/values/configs.dart';
import '../../../data/data_state.dart';
import '../../../data/remote/dto/request/top_headlines_request.dart';
import '../../../data/repository/news_api_repository.dart';
import '../../../model/news/article.dart';
import '../base_cubit.dart';
import 'top_headlines_state.dart';

class TopHeadlinesCubit extends BaseCubit<TopHeadlinesState> {
  final NewsApiRepository _apiRepository;

  TopHeadlinesCubit(this._apiRepository) : super(const Loading());

  Future<void> fetchTopHeadlines(int page, {String? keyword}) async {
    if (isBusy) return;

    await run(() async {
      final response = await _apiRepository.fetchTopHeadlines(
          request: TopHeadlinesRequest(page: page, keyword: keyword));

      if (response is DataSuccess) {
        final articles = response.data?.articles ?? <Article>[];
        final isLastPage = articles.length < Configuration.pageSizeDefault;

        emit(Content(
          articles: articles,
          isLastPage: isLastPage,
          nextPage: page + 1,
        ));
      } else {
        emit(Failed(exception: response.exception));
      }
    });
  }
}
