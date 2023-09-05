import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../config/configuration.dart';
import '../data/remote/api_service.dart';
import '../data/repository/api_repository.dart';
import '../data/repository/api_repository_impl.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  final dio = Dio();
  dio.options.headers['X-Api-Key'] = Configuration.apiKey;
  dio.interceptors.add(AwesomeDioInterceptor(
    logResponseHeaders: false,
  ));
  locator.registerSingleton<Dio>(dio);

  locator.registerSingleton<ApiService>(ApiService(locator<Dio>()));

  locator.registerSingleton<ApiRepository>(
      ApiRepositoryImpl(locator<ApiService>()));
}
