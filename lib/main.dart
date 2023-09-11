import 'package:flutter/material.dart';
import 'package:research_and_development/src/injection/locator.dart';

import 'res/values/routes.dart';
import 'res/values/strings.dart';
import 'res/values/themes.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized;

  await initializeDependencies();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: Strings.appName,
        theme: Themes.mainDefault,
        routerConfig: Routes.routerConfig,
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
      );
}
