import 'package:flutter/material.dart';

abstract class Styles {
  static ColorScheme schemeTeal = ColorScheme.fromSeed(seedColor: Colors.teal);

  static ColorScheme schemeDeepOrange =
      ColorScheme.fromSeed(seedColor: Colors.deepOrange);

  static ColorScheme schemePurple =
      ColorScheme.fromSeed(seedColor: Colors.purple);

  static ColorScheme schemeBlue = ColorScheme.fromSeed(seedColor: Colors.blue);

  static TextStyle titleTextStyle = const TextStyle(
    fontSize: 22.0,
    fontFamily: 'Fragment Mono',
    fontWeight: FontWeight.w400,
  );

  static AppBarTheme get appBarThemeBlue => AppBarTheme(
        backgroundColor: Styles.schemeBlue.primary,
        foregroundColor: Styles.schemeBlue.onPrimary,
        titleTextStyle: Styles.titleTextStyle,
        elevation: 16.0,
      );

  static AppBarTheme get appBarThemeDeepOrange => AppBarTheme(
        backgroundColor: Styles.schemeDeepOrange.primary,
        foregroundColor: Styles.schemeDeepOrange.onPrimary,
        titleTextStyle: Styles.titleTextStyle,
        elevation: 16.0,
      );

  static AppBarTheme get appBarThemePurple => AppBarTheme(
        backgroundColor: Styles.schemePurple.primary,
        foregroundColor: Styles.schemePurple.onPrimary,
        titleTextStyle: Styles.titleTextStyle,
        elevation: 16.0,
      );
}
