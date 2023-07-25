import 'package:flutter/material.dart';
import 'package:research_and_development/feature/navigation/NavigationHome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        fontFamily: 'Roboto Mono',
      ),
      home: const MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home),
            SizedBox(width: 16.0),
            Text(
              'Main Menu',
              semanticsLabel: 'main menu',
              style: TextStyle(fontFamily: 'Fragment Mono'),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        scrollDirection: Axis.vertical,
        children: [
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                print('main_menu: navigation');
                // Navigator.pushNamed(context, '/navigation');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NavigationContent(),
                  ),
                );
              },
              child: const Text(
                'navigation',
                semanticsLabel: 'navigation',
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                print('main_menu: data_list');
              },
              child: const Text(
                'data_list',
                semanticsLabel: 'data list',
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                print('main_menu: networking');
              },
              child: const Text(
                'networking',
                semanticsLabel: 'networking',
              ),
            ),
          ),
          for (var idx = 0; idx < 21; idx++)
            Column(
              children: [
                const SizedBox(height: 16.0),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'feature #${idx + 1} tba!',
                    ),
                  ),
                ),
              ],
            ),
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
