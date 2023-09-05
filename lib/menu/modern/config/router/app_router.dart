import 'package:auto_route/auto_route.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: TopHeadlinesUi.page, initial: true),
      ];
}

final appRouter = AppRouter();
