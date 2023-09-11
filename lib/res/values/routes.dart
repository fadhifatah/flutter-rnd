import 'package:go_router/go_router.dart';
import 'package:research_and_development/src/feature/navigation2/navigation2.dart';

import '../../src/feature/main_menu/main_menu.dart';
import '../../src/feature/modern/modern.dart';
import '../../src/feature/navigation/navigation.dart';

abstract class Routes {
  static final routerConfig = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MainMenu(),
        routes: [
          /* GoRoute(
            path: ':path',
            name: 'path',
            builder: (context, state) {
              final argumentString = state.extra.toString();
              final pathParamsString = state.pathParameters.toString();
              final queryParamsString = state.uri.queryParameters.toString();

              return PageNotFound(
                argument: argumentString,
                path: pathParamsString,
                query: queryParamsString,
              );
            },
          ), */
        ],
      ),
      GoRoute(
        path: '/:path',
        builder: (context, state) {
          final argument = state.extra;
          final pathParams = state.pathParameters;
          final queryParams = state.uri.queryParameters;

          if (pathParams['path'] == 'navigation') {
            return const Navigation();
          } else if (pathParams['path'] == 'navigation2') {
            return const Navigation2App(); // don't try this; bad example!
          } else if (pathParams['path'] == 'modern') {
            return const ModernApp();
          }

          return PageNotFound(
            argument: argument.toString(),
            path: pathParams.toString(),
            query: queryParams.toString(),
          );
        },
      ),
      /* GoRoute(
        path: '/navigation',
        builder: (context, state) => const NavigationApp(),
      ),
      GoRoute(
        path: '/navigation2',
        builder: (context, state) => const Navigation2App(),
      ), */
    ],
    debugLogDiagnostics: true,
  );
}
