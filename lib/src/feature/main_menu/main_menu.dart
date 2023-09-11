import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../jsonplaceholder/jsonplaceholder.dart';
import '../pexels/pexels.dart';

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
                  // GoRouter.of(context).replace('/navigation2');
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
                  // https://pub.dev/documentation/go_router/latest/topics/Navigation-topic.html
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const JsonPlaceholder(),
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
                  // https://pub.dev/documentation/go_router/latest/topics/Navigation-topic.html
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Pexels(),
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
                  GoRouter.of(context).push('/news');
                },
                child: const Text(
                  'news',
                  semanticsLabel: 'news',
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
