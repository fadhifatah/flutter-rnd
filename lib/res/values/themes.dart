import 'package:flutter/material.dart';

import 'styles.dart';

abstract class Themes {
  static ThemeData get modern {
    return ThemeData(
      colorScheme: Styles.schemeBlue,
      fontFamily: 'Roboto Mono',
      appBarTheme: AppBarTheme(
        backgroundColor: Styles.schemeBlue.primary,
        foregroundColor: Styles.schemeBlue.onPrimary,
        titleTextStyle: Styles.titleTextStyle,
        elevation: 16.0,
      ),
    );
  }

  static ThemeData get mainDefault {
    return ThemeData(
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
      colorScheme: Styles.schemeTeal,
      useMaterial3: true,
      fontFamily: 'Roboto Mono',
      appBarTheme: AppBarTheme(
        backgroundColor: Styles.schemeTeal.primary,
        foregroundColor: Styles.schemeTeal.onPrimary,
        elevation: 16.0,
        titleTextStyle: Styles.titleTextStyle,
      ),
    );
  }
}
