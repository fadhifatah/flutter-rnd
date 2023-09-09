import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../res/values/configs.dart';
import '../data/local/floor/dao/saved_headlines_dao.dart';
import '../data/local/floor/db/news_database.dart';
import '../data/remote/api/news_service.dart';
import '../data/repository/news_api_repository.dart';
import '../data/repository/news_api_repository_impl.dart';
import '../data/repository/news_db_repository.dart';
import '../data/repository/news_db_repository_impl.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  final newsDatabase = await $FloorNewsDatabase
      .databaseBuilder(Configuration.newsDatabaseName)
      .build();

  locator.registerSingleton<NewsDatabase>(newsDatabase);

  locator.registerSingleton<SavedHeadlinesDao>(
      locator<NewsDatabase>().topHeadlinesDao);

  final dio = Dio();
  dio.options.headers['X-Api-Key'] = Configuration.newsApiKey;
  dio.interceptors.add(AwesomeDioInterceptor(
    logResponseHeaders: false,
  ));
  locator.registerSingleton<Dio>(dio);

  locator.registerSingleton<NewsApiService>(NewsApiService(locator<Dio>()));

  locator.registerSingleton<NewsApiRepository>(
      NewsApiRepositoryImpl(locator<NewsApiService>()));

  locator.registerSingleton<NewsDbRepository>(
      NewsDbRepositoryImpl(locator<SavedHeadlinesDao>()));
}
