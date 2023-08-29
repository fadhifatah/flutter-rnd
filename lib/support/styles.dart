import 'package:flutter/material.dart';

abstract class Styles {
  static ColorScheme schemeTeal =
      ColorScheme.fromSeed(seedColor: Colors.teal);

  static ColorScheme schemeDeepOrange =
      ColorScheme.fromSeed(seedColor: Colors.deepOrange);

  static ColorScheme schemePurple =
      ColorScheme.fromSeed(seedColor: Colors.purple);

  static TextStyle titleTextStyle = const TextStyle(
      fontSize: 22.0, fontFamily: 'Fragment Mono', fontWeight: FontWeight.w400);
}
