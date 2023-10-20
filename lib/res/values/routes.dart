import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../src/feature/main_menu/main_menu.dart';
import '../../src/feature/navigation/navigation.dart';
import '../../src/feature/navigation2/navigation2.dart';
import '../../src/feature/news/news_headlines.dart';

abstract class Routes {
  static final routerConfig = GoRouter(
    routes: [
      GoRoute(
        path: Navigator.defaultRouteName,
        builder: (context, state) => const MainMenu(),
        routes: [
          GoRoute(
            path: 'navigation',
            builder: (context, state) => const Navigation(),
          ),
          GoRoute(
            path: 'news',
            builder: (context, state) => const NewsHeadlines(),
          ),
        ],
      ),
      GoRoute(
        path: '/navigation2',
        name: Names.navigation2,
        builder: (context, state) {
          final argument = state.extra;
          final pathParams = state.pathParameters;
          final queryParams = state.uri.queryParameters;

          if (/* argument != null ||
              pathParams.isNotEmpty || */
              queryParams.isNotEmpty) {
            return PageNotFound(
              argument: argument.toString(),
              path: pathParams.toString(),
              query: queryParams.toString(),
            );
          } else {
            return Navigation2(); // don't try this; bad example!
          }
        },
        routes: [
          GoRoute(
            path: 'a',
            name: Names.pageNameA,
            pageBuilder: (context, state) {
              final arguments =
                  state.extra as Map<String, dynamic>? ?? <String, dynamic>{};

              return MaterialPage(
                child: PageA(args: arguments),
                name: Names.pageNameA,
                arguments: arguments,
              );
            },
          ),
          GoRoute(
            path: 'b',
            name: Names.pageNameB,
            // builder: (context, state) => PageB(),
            // Define pageBuilder if corresponding page is accessing the 
            // arguments from ModalRoute where the arguments is passed from 
            // GoRouter.pushNamed() or GoRouter.push() function. ModalRoute 
            // store properties such as RouteSettings which it must be created 
            // first using MaterialPage!
            pageBuilder: (context, state) {
              final arguments =
                  state.extra as Map<String, dynamic>? ?? <String, dynamic>{};

              return MaterialPage(
                child: PageB(),
                name: Names.pageNameB,
                arguments: arguments,
              );
            },
          ),
          /* GoRoute(
            path: 'c',
            name: Names.pageNameC,
            builder: (context, state) => PageC(),
          ), */ 
          // pageBuilder is not necessary because the arguments passed on 
          // Navigator.push() with MaterialPageRoute as page builder.
          GoRoute(
            path: 'd',
            name: Names.pageNameD,
            builder: (context, state) => PageD(),
          )
        ],
      ),
    ],
    debugLogDiagnostics: true,
  );
}

/// Supported routes that is handled in navigation2
abstract class Names {
  static const String navigation2 = 'navigation2';
  static const String pageNameA = 'a';
  static const String pageNameB = 'b';
  // static const String pageNameC = 'c'; // Not used anymore!
  static const String pageNameD = 'd';
}

/// Extras to read any arguments passed
abstract class Arguments {
  static const String argument = 'argument';
  static const String result = 'result';
}
