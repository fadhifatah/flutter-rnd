import '../data_state.dart';
import '../dto/request/top_headlines_request.dart';
import '../dto/response/top_headlines_response.dart';

abstract class ApiRepository {
  Future<DataState<TopHeadlinesResponse>> fetchTopHeadlines({
    required TopHeadlinesRequest request,
  });
}
