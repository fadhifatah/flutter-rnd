import 'package:flutter/material.dart';
import 'package:research_and_development/feature/navigation/navigation_simple.dart';
import 'package:research_and_development/feature/networking/jsonplaceholder.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  /* Route? _onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/': // root
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MainMenu(),
        );
      /* case '/navigation':
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const NavigationHome(),
        ); */
      default:
        return null;
    }
  }

  Route _onUnknownRoute(RouteSettings routeSettings) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const PageNotFound(),
    );
  } */

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.teal);

    return MaterialApp(
      title: 'Flutter RnD',
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
          titleTextStyle: TextStyle(
            fontFamily: 'Fragment Mono',
            fontSize: 22.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      home: const MainMenu(),
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
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              ElevatedButton(
                onPressed: () {
                  print('main_menu: navigation');
                  // Navigator.pushNamed(context, '/navigation');
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const NavigationApp(),
                    ),
                    (route) => false,
                  );
                },
                child: const Text(
                  'navigation',
                  semanticsLabel: 'navigation',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print('main_menu: navigation_named');
                  // Navigator.pushNamed(context, '/navigation');
                  /* Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const NavigationApp(),
                    ),
                    (route) => false,
                  ); */
                },
                child: const Text(
                  'navigation_named',
                  semanticsLabel: 'navigation named',
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
                },
                child: const Text(
                  'pexels',
                  semanticsLabel: 'pexels',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print('main_menu: retrofit');
                },
                child: const Text(
                  'retrofit',
                  semanticsLabel: 'retrofit',
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
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.deepOrange.shade50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Page not found.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 48.0,
                fontWeight: FontWeight.w500,
                fontFamily: 'Fragment Mono',
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                /* Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false); */
              },
              child: const Icon(
                Icons.home,
                color: Colors.deepOrangeAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
