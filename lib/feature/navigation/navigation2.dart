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
          final args = settings.arguments as String? ?? 'EMPTY';

          return MaterialPageRoute(builder: (context) => PageA(args: args),)
        }
      },
      routes: {
        Routes.root: (context) => Navigation2Main(),
      },
      initialRoute: Routes.root,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }
}

class Navigation2Main extends StatelessWidget {
  Navigation2Main({super.key});

  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation2'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton.icon(
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
              const SizedBox(height: 32.0),
              TextField(
                controller: _inputController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.add),
                  hintText: 'Type something as argument!',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.pageA,
                    arguments: _inputController.text,
                  );
                },
                child: const Text('Go to A'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PageA extends StatelessWidget {
  PageA({super.key, required String args});

  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final argsExtracted =
        ModalRoute.of(context)?.settings.arguments as String? ?? 'EMPTY';

    return Scaffold(
      appBar: AppBar(
        title: const Text('A'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Argument passed here: $argsExtracted'),
              const SizedBox(height: 32.0),
              TextField(
                controller: _inputController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.add),
                  hintText: 'Type something as argument!',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.pageA,
                    arguments: _inputController.text,
                  );
                },
                child: const Text('Send Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class PageB extends StatelessWidget {
  PageB({super.key, required this.args});
  final String args;

  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final argsExtracted =
        ModalRoute.of(context)?.settings.arguments as String? ?? 'EMPTY';

    return Scaffold(
      appBar: AppBar(
        title: const Text('A'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Argument passed here: $args'),
              Text('Argument extracted here: $argsExtracted'),
              const SizedBox(height: 32.0),
              TextField(
                controller: _inputController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.add),
                  hintText: 'Type something as argument!',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.pageA,
                    arguments: _inputController.text,
                  );
                },
                child: const Text('Send Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class PageC extends StatelessWidget {
  PageC({super.key, required String args});

  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final argsExtracted =
        ModalRoute.of(context)?.settings.arguments as String? ?? 'EMPTY';

    return Scaffold(
      appBar: AppBar(
        title: const Text('A'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Argument passed here: $argsExtracted'),
              const SizedBox(height: 32.0),
              TextField(
                controller: _inputController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.add),
                  hintText: 'Type something as argument!',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.pageA,
                    arguments: _inputController.text,
                  );
                },
                child: const Text('Send Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
