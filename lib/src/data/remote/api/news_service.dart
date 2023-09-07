import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../res/values/configs.dart';
import '../dto/response/top_headlines_response.dart';

part 'news_service.g.dart';

@RestApi(baseUrl: Configuration.newsBaseUrl, parser: Parser.JsonSerializable)
abstract class NewsApiService {
  factory NewsApiService(Dio dio, {String baseUrl}) = _NewsApiService;

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
