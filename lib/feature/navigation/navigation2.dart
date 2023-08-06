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
        print('onGenerateRoute');
        if (settings.name == Routes.pageA) {
          print('settings.name == page-a');
          final args =
              settings.arguments as String? ?? 'EMPTY from \'onGenerateRoute\'';

          return MaterialPageRoute(
            builder: (context) => PageA(args: args),
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
                  arguments: _inputController.text,
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
                  arguments: _inputController.text,
                );
              },
              child: const Text('Send to B'),
            ),
          ),
          Align(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.pageC,
                  arguments: _inputController.text,
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
  final String args;
  PageA({super.key, required this.args});

  @override
  State<PageA> createState() => _PageAState();
}

class _PageAState extends State<PageA> {
  late TextEditingController _inputController;

  var result = '';

  Future<void> _cForResult() async {
    final resultFromC = await Navigator.pushNamed(
          context,
          Routes.pageC,
          arguments: _inputController.text,
        ) as String? ??
        'EMPTY';

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) {
      return;
    }

    setState(() {
      result = resultFromC;
    });
  }

  @override
  void initState() {
    _inputController = TextEditingController(text: widget.args);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _inputController.text = widget.args;

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
                  arguments: _inputController.text,
                );
              },
              child: const Text('Send to B'),
            ),
            ElevatedButton(
              onPressed: () => _cForResult(),
              child: const Text('Get result from C'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.pageD);
              },
              child: const Text('Go to D'),
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
    final argument = ModalRoute.of(context)?.settings.arguments as String? ??
        'EMPTY from \'ModalRoute\'';
    _inputController.text = argument;

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
                Navigator.pushNamed(
                  context,
                  Routes.pageC,
                  arguments: _inputController.text,
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
                Navigator.pop(context, _inputController.text);
              },
              child: const Text('Send back'),
            ),
          ),
          Align(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _inputController.text);
              },
              child: const Text('Send back (until)'),
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
                  arguments: _inputController.text,
                );
              },
              child: const Text('Send to D'),
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
                Navigator.pop(context, _inputController.text);
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
