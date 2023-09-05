import 'package:flutter/material.dart';

import '../../../../support/styles.dart';

abstract class AppTheme {
  static ThemeData get light {
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
}
