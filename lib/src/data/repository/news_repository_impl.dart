import '../../../../src/data/remote/api/news_service.dart';
import '../data_state.dart';
import '../remote/dto/request/top_headlines_request.dart';
import '../remote/dto/response/top_headlines_response.dart';
import 'base_repository.dart';
import 'news_repository.dart';

class NewsRepositoryImpl extends BaseRepository implements NewsRepository {
  final NewsApiService _apiService;

  NewsRepositoryImpl(this._apiService);

  @override
  Future<DataState<TopHeadlinesResponse>> fetchTopHeadlines({
    required TopHeadlinesRequest request,
  }) {
    return getStateOf(
      request: () => _apiService.getTopHeadlines(
        category: request.category,
        country: request.country,
        keyword: request.keyword,
        page: request.page,
        pageSize: request.pageSize,
        source: request.source,
      ),
    );
  }
}
