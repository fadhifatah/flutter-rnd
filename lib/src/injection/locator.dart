import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../res/values/configs.dart';
import '../data/remote/api/news_service.dart';
import '../data/repository/news_repository.dart';
import '../data/repository/news_repository_impl.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  final dio = Dio();
  dio.options.headers['X-Api-Key'] = Configuration.newsApiKey;
  dio.interceptors.add(AwesomeDioInterceptor(
    logResponseHeaders: false,
  ));
  locator.registerSingleton<Dio>(dio);

  locator.registerSingleton<NewsApiService>(NewsApiService(locator<Dio>()));

  locator.registerSingleton<NewsRepository>(
      NewsRepositoryImpl(locator<NewsApiService>()));
}
