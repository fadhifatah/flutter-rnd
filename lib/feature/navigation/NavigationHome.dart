import 'package:flutter/material.dart';

import '../../main.dart';

class NavigationHome extends StatelessWidget {
  const NavigationHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FLutter Navigation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const NavigationContent(),
    );
  }
}

class NavigationContent extends StatelessWidget {
  const NavigationContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text(
          'Navigation',
          style: TextStyle(fontFamily: 'Fragment Mono'),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigator.pop(context);
                Navigator.of(context, rootNavigator: true).pop(
                  MaterialPageRoute(builder: (context) => const MainMenu()),
                );
                /* Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainMenu(),
                  ),
                ); */
              },
              child: const Icon(Icons.home),
            ),
          ],
        ),
      ),
    );
  }
}
