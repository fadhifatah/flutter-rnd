import 'package:flutter/material.dart';
import 'package:research_and_development/src/feature/navigation2/routes.dart';
import 'package:research_and_development/res/values/styles.dart';
import 'package:url_launcher/link.dart';

/// This app is used to display Flutter navigation capabilities. There will be
/// five pages: Navigation2, A, B, C and D. Each navigation from/to will access
/// TextField input to be passed.
///
/// For example: At Navigation2 you may type something as argument in TextField.
/// When you click "Send to A", the value will be passed.
///
/// Other example: At C, you may passed down the value to be passed down when
/// "Send back" is clicked.
class Navigation2App extends StatelessWidget {
  const Navigation2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: Styles.schemePurple,
        fontFamily: 'Roboto Mono',
        appBarTheme: AppBarTheme(
          backgroundColor: Styles.schemePurple.primary,
          foregroundColor: Styles.schemePurple.onPrimary,
          titleTextStyle: Styles.titleTextStyle,
          elevation: 16.0,
        ),
      ),
      onGenerateRoute: (settings) {
        // This is an example of passing argument using onGenerateRoute
        // You must defien and register which page that may receive an argument.
        // In this case, it is [Routes.pageA]
        if (settings.name == Routes.pageA) {
          final args = settings.arguments as Map<String, dynamic>? ??
              <String, dynamic>{};

          return MaterialPageRoute(
            builder: (context) => PageA(args: args),
            // This extra data (settings) used to reserve possible argument at
            // this page based on https://stackoverflow.com/a/56218929/18139177
            //
            // ignore: prefer_const_constructors
            settings: RouteSettings(
              name: Routes.pageA,
              arguments: <String, dynamic>{},
            ),
          );
        }

        return null;
      },
      routes: {
        // This is an example of normal routes that commonly used.
        Routes.root: (context) => Navigation2Main(),
        // Routes.pageA: (context) => PageA(args: {}),
        Routes.pageB: (context) => PageB(),
        Routes.pageC: (context) => PageC(),
        Routes.pageD: (context) => PageD(),
      },
      initialRoute: Routes.root, // Must declared
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }
}

/// The main content to access A, B, C and D
class Navigation2Main extends StatelessWidget {
  Navigation2Main({super.key});

  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation2'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        shrinkWrap: true,
        children: [
          Align(
            child: Link(
              uri: Uri.parse('https://frnd.fadhifatah.dev/'),
              builder: (context, followLink) => IconButton(
                onPressed: followLink,
                icon: const Icon(Icons.home),
              ),
            ),
          ),
          /* Align(
            child: IconButton(
              onPressed: () {
                // Back to Main Menu a.k.a start new Main Menu app
                print('Go Back to Main Menu');
                // context.go('/');
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => MainApp(),
                  ),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.home),
            ),
          ), */
          Align(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.pageA,
                  arguments: {
                    Arguments.argument: _inputController.text,
                  },
                );
              },
              child: const Text('Send to A'),
            ),
          ),
          Align(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.pageB,
                  arguments: {
                    Arguments.argument: _inputController.text,
                  },
                );
              },
              child: const Text('Send to B'),
            ),
          ),
          Align(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageC(),
                    settings: RouteSettings(
                      name: Routes.pageC,
                      arguments: {
                        Arguments.argument: _inputController.text,
                      },
                    ),
                  ),
                );
              },
              child: const Text('Send to C'),
            ),
          ),
          Align(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.pageD,
                );
              },
              child: const Text('Go to D'),
            ),
          ),
          // Where argument take places
          TextField(
            controller: _inputController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.add),
              hintText: 'Type something as argument!',
            ),
          ),
        ],
      ),
    );
  }
}

/// This page contains result callback from two scenarios:
/// 1. Get result from C: At C, you may input text in TextField then it will be
/// passed down to A.
///
/// 2. Expect result from D via B: At D (in the end), you may input text in
/// TextField then it will be passed down to A. This scenario simulate when A
/// needs data from other page further which is D. In this case, D will be
/// located after B or even C. So, when jumped from D to A, make sure the data
/// still exist.
class PageA extends StatefulWidget {
  final Map<String, dynamic> args;
  PageA({super.key, required this.args});

  @override
  State<PageA> createState() => _PageAState();
}

class _PageAState extends State<PageA> {
  late TextEditingController _inputController;

  var result = '';

  Future<void> _dViaBForResult() async {
    // https://stackoverflow.com/a/56218929/18139177
    await Navigator.pushNamed(
      context,
      Routes.pageB,
      arguments: {
        Arguments.argument: _inputController.text,
      },
    ).then((_) {
      final resultFromD =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
              <String, dynamic>{};

      setState(() {
        result = resultFromD[Arguments.result] ?? 'EMPTY';
      });
    });

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) {
      return;
    }
  }

  // A simple result callback: go to that page and pass down the data as result.
  Future<void> _cForResult() async {
    final resultFromC = await Navigator.pushNamed(
          context,
          Routes.pageC,
          arguments: {
            Arguments.argument: _inputController.text,
          },
        ) as Map<String, dynamic>? ??
        <String, dynamic>{};

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) {
      return;
    }

    setState(() {
      result = resultFromC[Arguments.result] ?? 'EMPTY';
    });
  }

  @override
  void initState() {
    // We may read argument to be put in other properties, instantly.
    _inputController =
        TextEditingController(text: widget.args[Arguments.argument]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Align(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.pageB,
                  arguments: {
                    Arguments.argument: _inputController.text,
                  },
                );
              },
              child: const Text('Send to B'),
            ),
          ),
          Align(
            child: ElevatedButton(
              onPressed: () => _cForResult(),
              child: const Text('Get result from C'),
            ),
          ),
          Align(
            child: ElevatedButton(
              onPressed: () => _dViaBForResult(),
              child: const Text('Expect result from D via B'),
            ),
          ),
          TextField(
            controller: _inputController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.add),
              hintText: 'Type something as argument!',
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Result: $result'),
          ),
        ],
      ),
    );
  }
}

class PageB extends StatelessWidget {
  PageB({super.key});

  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final argument =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
            <String, dynamic>{};
    _inputController.text = argument[Arguments.argument];

    return Scaffold(
      appBar: AppBar(
        title: const Text('B'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        shrinkWrap: true,
        children: [
          Align(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageC(),
                    settings: RouteSettings(
                      name: Routes.pageC,
                      arguments: {
                        Arguments.argument: _inputController.text,
                      },
                    ),
                  ),
                );
              },
              child: const Text('Send to C'),
            ),
          ),
          Align(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.pageD);
              },
              child: const Text('Go to D'),
            ),
          ),
          TextField(
            controller: _inputController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.add),
              hintText: 'Type something as argument!',
            ),
          ),
        ],
      ),
    );
  }
}

/// Contains huge jump into Navigation2
class PageC extends StatelessWidget {
  PageC({super.key});

  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final argument =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
            <String, dynamic>{};
    _inputController.text = argument[Arguments.argument];

    return Scaffold(
      appBar: AppBar(
        title: const Text('C'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        shrinkWrap: true,
        children: [
          Align(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  {
                    Arguments.result: _inputController.text,
                  },
                );
              },
              child: const Text('Send back'),
            ),
          ),
          Align(
            child: ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName(Routes.root));
              },
              child: const Text('Back to Navigation2'),
            ),
          ),
          Align(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.pageD,
                );
              },
              child: const Text('Go to D'),
            ),
          ),
          TextField(
            controller: _inputController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.add),
              hintText: 'Type something as argument!',
            ),
          ),
        ],
      ),
    );
  }
}

/// Contains huge jump into Navigation2. Implement [Navigator.popUntil] with
/// containing data.
class PageD extends StatelessWidget {
  PageD({super.key});

  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('D'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Align(
            child: ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) {
                  if (route.settings.name == Routes.pageA) {
                    (route.settings.arguments
                            as Map<String, dynamic>?)?[Arguments.result] =
                        _inputController.text;
                    return true;
                  } else {
                    // If not, back to Navigation2
                    return route.settings.name == Routes.root;
                  }
                });
              },
              child: const Text('Send back to A'),
            ),
          ),
          Align(
            child: ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName(Routes.root));
              },
              child: const Text('Back to Navigation2'),
            ),
          ),
          TextField(
            controller: _inputController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.add),
              hintText: 'Type something as argument!',
            ),
          ),
        ],
      ),
    );
  }
}
