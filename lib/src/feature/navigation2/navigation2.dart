import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../res/values/routes.dart';

/// This app is used to display Flutter navigation capabilities. There will be
/// five pages: Navigation2, A, B, C and D. Each navigation from/to will access
/// TextField input to be passed.
///
/// For example: At Navigation2 you may type something as argument in TextField.
/// When you click "Send to A", the value will be passed.
///
/// Other example: At C, you may passed down the value to be passed down when
/// "Send back" is clicked.
///
/// UPDATE:
/// This class has beed changed to use go_router as its main navigator.
/// This example is also a proof of go_router and Navigator API continuation.
///
/* class Navigation2App extends StatelessWidget {
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
        // In this case, it is [Names.pageNameA]
        if (settings.name == Names.pageNameA) {
          final args = settings.arguments as Map<String, dynamic>? ??
              <String, dynamic>{};

          return MaterialPageRoute(
            builder: (context) => PageA(args: args),
            // This extra data (settings) used to reserve possible argument at
            // this page based on https://stackoverflow.com/a/56218929/18139177
            //
            // ignore: prefer_const_constructors
            settings: RouteSettings(
              name: Names.pageNameA,
              arguments: <String, dynamic>{},
            ),
          );
        }

        return null;
      },
      routes: {
        // This is an example of normal routes that commonly used.
        Names.navigation2: (context) => Navigation2(),
        // Names.pageNameA: (context) => PageA(args: {}),
        Names.pageNameB: (context) => PageB(),
        Names.pageNameC: (context) => PageC(),
        Names.pageNameD: (context) => PageD(),
      },
      initialRoute: Routes.root, // Must declared
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }
} */ // Replaced with go_router equivalent named routes

/// The main content to access A, B, C and D
class Navigation2 extends StatelessWidget {
  Navigation2({super.key});

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
          /* Align(
            child: Link(
              uri: Uri.parse('https://frnd.fadhifatah.dev/'),
              builder: (context, followLink) => IconButton(
                onPressed: followLink,
                icon: const Icon(Icons.home),
              ),
            ),
          ), */
          Align(
            child: IconButton(
              onPressed: () {
                // Back to Main Menu a.k.a start new Main Menu app
                print('Go Back to Main Menu');
                // context.go('/');
                /* Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const MainMenu(),
                  ),
                  (route) => false,
                ); */
                context.replace(Navigator.defaultRouteName);
              },
              icon: const Icon(Icons.home),
            ),
          ),
          Align(
            child: ElevatedButton(
              onPressed: () {
                context.pushNamed(
                  Names.pageNameA,
                  extra: {
                    Arguments.argument: _inputController.text,
                  },
                );
                /* Navigator.pushNamed(
                  context,
                  Names.pageNameA,
                  arguments: {
                    Arguments.argument: _inputController.text,
                  },
                ); */ // To navigate with named routes with Navigator API
              },
              child: const Text('Send to A'),
            ),
          ),
          Align(
            child: ElevatedButton(
              onPressed: () {
                context.pushNamed(
                  Names.pageNameB,
                  extra: {
                    Arguments.argument: _inputController.text,
                  },
                );
                /* Navigator.pushNamed(
                  context,
                  Names.pageNameB,
                  arguments: {
                    Arguments.argument: _inputController.text,
                  },
                ); */
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
                      // name: Names.pageNameC,
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
                context.pushNamed(Names.pageNameD);
                // Navigator.pushNamed(context, Names.pageNameD);
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
    await context.pushNamed(
      Names.pageNameB,
      extra: {
        Arguments.argument: _inputController.text,
      },
    ).then((_) {
      // When a BuildContext is used from a StatefulWidget, the mounted property
      // must be checked after an asynchronous gap.
      if (!mounted) {
        return;
      }

      final resultFromD =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
              <String, dynamic>{};

      setState(() {
        result = resultFromD[Arguments.result] ?? 'EMPTY';
      });
    });

    // https://stackoverflow.com/a/56218929/18139177
    /* await Navigator.pushNamed(
      context,
      Names.pageNameB,
      arguments: {
        Arguments.argument: _inputController.text,
      },
    ).then((_) {
      // When a BuildContext is used from a StatefulWidget, the mounted property
      // must be checked after an asynchronous gap.
      if (!mounted) {
        return;
      }

      final resultFromD =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
              <String, dynamic>{};

      setState(() {
        result = resultFromD[Arguments.result] ?? 'EMPTY';
      });
    }); */
  }

  // A simple result callback: go to that page and pass down the data as result.
  Future<void> _cForResult() async {
    final resultFromC = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PageC(),
        settings: RouteSettings(
          // name: Names.pageNameC,
          arguments: {
            Arguments.argument: _inputController.text,
          },
        ),
      ),
    );
    /* final resultFromC = await Navigator.pushNamed(
          context,
          Names.pageNameC,
          arguments: {
            Arguments.argument: _inputController.text,
          },
        ) as Map<String, dynamic>? ??
        <String, dynamic>{}; */

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
                context.pushNamed(
                  Names.pageNameB,
                  extra: {
                    Arguments.argument: _inputController.text,
                  },
                );
                /* Navigator.pushNamed(
                  context,
                  Names.pageNameB,
                  arguments: {
                    Arguments.argument: _inputController.text,
                  },
                ); */
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
                      // name: Names.pageNameC,
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
                context.pushNamed(Names.pageNameD);
                // Navigator.pushNamed(context, Names.pageNameD);
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
                context.pop({
                  Arguments.result: _inputController.text,
                });
                /* Navigator.pop(
                  context,
                  {
                    Arguments.result: _inputController.text,
                  },
                ); */
              },
              child: const Text('Send back'),
            ),
          ),
          Align(
            child: ElevatedButton(
              onPressed: () {
                Navigator.popUntil(
                    context, ModalRoute.withName(Names.navigation2));
              },
              child: const Text('Back to Navigation2'),
            ),
          ),
          Align(
            child: ElevatedButton(
              onPressed: () {
                context.pushNamed(Names.pageNameD);
                // Navigator.pushNamed(context, Names.pageNameD);
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
                // Proof of go_router and Navigator API continuation.
                Navigator.popUntil(context, (route) {
                  if (route.settings.name == Names.pageNameA) {
                    (route.settings.arguments
                            as Map<String, dynamic>?)?[Arguments.result] =
                        _inputController.text;
                    return true;
                  } else {
                    // If not, back to Navigation2 (root)
                    // return route.settings.name == Names.navigation2;
                    return route.isFirst;
                  }
                });
              },
              child: const Text('Send back to A'),
            ),
          ),
          Align(
            child: ElevatedButton(
              onPressed: () {
                Navigator.popUntil(
                    context, ModalRoute.withName(Names.navigation2));
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
