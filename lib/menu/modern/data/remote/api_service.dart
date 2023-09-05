import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../config/configuration.dart';
import '../dto/response/top_headlines_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: Configuration.baseUrl, parser: Parser.JsonSerializable)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('top-headlines')
  Future<HttpResponse<TopHeadlinesResponse>> getTopHeadlines({
    @Query('country') String? country,
    @Query('category') String? category,
    @Query('source') String? source,
    @Query('q') String? keyword,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
  });
}
