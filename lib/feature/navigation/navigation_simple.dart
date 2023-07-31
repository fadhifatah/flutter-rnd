import 'package:flutter/material.dart';
import '../../main.dart';

class NavigationApp extends StatelessWidget {
  const NavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.deepOrange);
    return MaterialApp(
      title: 'Flutter Navigation',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
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
        fontFamily: 'Roboto Mono',
      ),
      home: NavigationContent(),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }
}

class NavigationContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Text('''
This simple navigation simulation has Navigation (this page as root), Detail and Preview.

The routes will be:

0. Navigation to Main Menu (the other app)
1. Navigation to Detail
2. Detail back to Navigation
3. Detail to Preview
4. Preview back to Detail
5. Preivew back to Navigation

The graph should look like:

    [🏠]
     |
[Navigation]-[Detail]-[Preview]
     |____________________|

This simulation, currently, has an animation issue. It just has been patched by setting up custom PageRouteBuilder for number (5), the others work fine fortunately.'''),
            SizedBox(height: 16.0),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.pop(context); // will close the app.
                  // Navigator.of(context/* , rootNavigator: true */).pop(
                  //   MaterialPageRoute(builder: (context) => const MainMenu()),
                  // );
                  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => MainApp()),
                    (route) => false,
                  );
                },
                child: Icon(Icons.home),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoToDetail(),
                      ));
                },
                child: Text('Go to Detail'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoToDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '''This is a detail page. Level 2.

A simple navigation with action back at App Bar to Navigation page.''',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Go Back'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoToPreview(),
                      ));
                },
                child: Text('Go to Preview'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GoToPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '''This is a preview page. Level 3.

A simple navigation with action back at App Bar to Detail page.''',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Go Back'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    // MaterialPageRoute(builder: (context) => NavigationContent(),)
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          NavigationContent(),
                      // transitionsBuilder:
                      //     (context, animation, secondaryAnimation, child) =>
                      //         FadeTransition(
                      //   opacity: animation,
                      //   child: /* child */FadeTransition(
                      //     opacity: Tween(begin: 1.0, end: 0.0)
                      //         .animate(secondaryAnimation),
                      //     child: child,
                      //   ),
                      // ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var tween = Tween(begin: 0.0, end: 1.0)
                            .chain(CurveTween(curve: Curves.easeOutBack));

                        return ScaleTransition(
                          scale: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                    (route) => false,
                  );
                },
                child: Text('Go Back to Navigation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
