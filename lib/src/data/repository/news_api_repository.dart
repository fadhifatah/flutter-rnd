import '../data_state.dart';
import '../remote/dto/request/top_headlines_request.dart';
import '../remote/dto/response/top_headlines_response.dart';

abstract class NewsApiRepository {
  Future<DataState<TopHeadlinesResponse>> fetchTopHeadlines({
    required TopHeadlinesRequest request,
  });
}
