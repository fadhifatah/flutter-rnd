import 'package:flutter/material.dart';

abstract class Styles {
  static ColorScheme colorScheme =
      ColorScheme.fromSeed(seedColor: Colors.deepOrange);

  static ColorScheme colorScheme2 =
      ColorScheme.fromSeed(seedColor: Colors.purple);

  static TextStyle titleTextStyle = const TextStyle(
      fontSize: 22.0, fontFamily: 'Fragment Mono', fontWeight: FontWeight.w400);
}
