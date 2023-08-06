import 'package:flutter/material.dart';
import 'package:research_and_development/feature/navigation/routes.dart';
import 'package:research_and_development/feature/navigation/styles.dart';
import 'package:research_and_development/main.dart';

class Navigation2App extends StatelessWidget {
  const Navigation2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: Styles.colorScheme2,
        fontFamily: 'Roboto Mono',
        appBarTheme: AppBarTheme(
          backgroundColor: Styles.colorScheme2.primary,
          foregroundColor: Styles.colorScheme2.onPrimary,
          titleTextStyle: Styles.titleTextStyle,
          elevation: 16.0,
        ),
      ),
      onGenerateRoute: (settings) {
        if (settings.name == Routes.pageA) {
          final args = settings.arguments as Map<String, dynamic>? ??
              <String, dynamic>{};

          return MaterialPageRoute(
            builder: (context) => PageA(args: args),
            // https://stackoverflow.com/a/56218929/18139177
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
        Routes.root: (context) => Navigation2Main(),
        // Routes.pageA: (context) => PageA(args: 'EMPTY from \'routes\''),
        Routes.pageB: (context) => PageB(),
        Routes.pageC: (context) => PageC(),
        Routes.pageD: (context) => PageD(),
      },
      initialRoute: Routes.root,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }
}

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
            child: ElevatedButton.icon(
              onPressed: () {
                print('Go Back to Main Menu');
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const MainApp(),
                  ),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.home),
              label: const Text('Main Menu'),
            ),
          ),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
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
            ElevatedButton(
              onPressed: () => _cForResult(),
              child: const Text('Get result from C'),
            ),
            ElevatedButton(
              onPressed: () => _dViaBForResult(),
              child: const Text('Expect result from D via B'),
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
