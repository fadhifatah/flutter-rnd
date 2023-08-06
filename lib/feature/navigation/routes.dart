import 'package:flutter/widgets.dart';

/// Supported routes that can only be handled in navigation2
abstract class Routes {
  static const String root = Navigator.defaultRouteName;
  static const String pageA = 'page-a';
  static const String pageB = 'page-b';
  static const String pageC = 'page-c';
  static const String pageD = 'page-d';
}

/// Extras to read any arguments passed
abstract class Arguments {
  static const String argument = 'argument';
  static const String result = 'result';
}
