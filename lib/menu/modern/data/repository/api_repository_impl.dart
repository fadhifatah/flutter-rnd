import '../data_state.dart';
import '../dto/request/top_headlines_request.dart';
import '../dto/response/top_headlines_response.dart';
import '../remote/api_service.dart';
import 'api_repository.dart';
import 'base_repository.dart';

class ApiRepositoryImpl extends BaseRepository implements ApiRepository {
  final ApiService _apiService;

  ApiRepositoryImpl(this._apiService);

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
