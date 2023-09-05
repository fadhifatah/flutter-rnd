import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:research_and_development/menu/jsonplaceholder/jsonplaceholder.dart';
import 'package:research_and_development/menu/modern/injection/locator.dart';
import 'package:research_and_development/menu/navigation/navigation.dart';
import 'package:research_and_development/menu/navigation2/navigation2.dart';
import 'package:research_and_development/menu/pexels/pexels.dart';
import 'package:research_and_development/support/styles.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized;

  await initializeDependencies();
  
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _router = GoRouter(
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
            return const NavigationApp(); // don't try this; bad example!
          } else if (pathParams['path'] == 'navigation2') {
            return const Navigation2App(); // don't try this; bad example!
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
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final colorScheme = Styles.schemeTeal;

    return MaterialApp.router(
      title: 'Flutter Research and Development',
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: colorScheme,
        useMaterial3: true,
        fontFamily: 'Roboto Mono',
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 16.0,
          titleTextStyle: Styles.titleTextStyle,
        ),
      ),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 16.0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home),
            SizedBox(width: 16.0),
            Text(
              'Main Menu',
              semanticsLabel: 'main menu',
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              ElevatedButton(
                onPressed: () {
                  print('main_menu: navigation');
                  GoRouter.of(context).replace('/navigation');
                  /* Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const NavigationApp(),
                    ),
                    (route) => false,
                  ); */
                },
                child: const Text(
                  'navigation',
                  semanticsLabel: 'navigation',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print('main_menu: navigation2');
                  GoRouter.of(context).replace('/navigation2');
                  /* Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const Navigation2App(),
                    ),
                    (route) => false,
                  ); */
                },
                child: const Text(
                  'navigation2',
                  semanticsLabel: 'navigation two',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print('main_menu: jsonplaceholder');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JsonPlaceholder(),
                      ));
                },
                child: const Text(
                  'jsonplaceholder',
                  semanticsLabel: 'json placeholder',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print('main_menu: pexels');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Pexels(),
                      ));
                },
                child: const Text(
                  'pexels',
                  semanticsLabel: 'pexels',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print('main_menu: modern');
                },
                child: const Text(
                  'modern',
                  semanticsLabel: 'modern',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print('main_menu: data_list');
                },
                child: const Text(
                  'data_list',
                  semanticsLabel: 'data list',
                ),
              ),
              for (var idx = 0; idx < 21; idx++)
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'feature #${idx + 1} tba!',
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}

class PageNotFound extends StatelessWidget {
  final String argument;
  final String path;
  final String query;

  PageNotFound({
    super.key,
    required this.argument,
    required this.path,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /* Link(
              uri: Uri.parse('http://frnd.fadhifatah.dev/'),
              builder: (context, followLink) => ElevatedButton(
                onPressed: followLink,
                child: const Icon(Icons.arrow_back),
              ),
            ), */
            ElevatedButton(
              onPressed: () {
                context.go('/');
              },
              child: const Icon(Icons.arrow_back),
            ),
            const Text(
              'Page not found.',
              style: TextStyle(
                color: Colors.red,
                fontSize: 48.0,
                fontWeight: FontWeight.w500,
                fontFamily: 'Fragment Mono',
              ),
            ),
            const SizedBox(height: 32.0),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('You are looking for:'),
            ),
            Table(
              columnWidths: {
                0: const IntrinsicColumnWidth(),
                1: const IntrinsicColumnWidth(),
                2: const FlexColumnWidth(),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.top,
              children: [
                TableRow(
                  children: [
                    const Text('argument'),
                    const Text(': '),
                    Text(argument),
                  ],
                ),
                TableRow(
                  children: [
                    const Text('path'),
                    const Text(': '),
                    Text(path),
                  ],
                ),
                TableRow(
                  children: [
                    const Text('query'),
                    const Text(': '),
                    Text(query),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
