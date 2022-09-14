import 'package:flutter/widgets.dart';

@immutable
abstract class Environment {
  String get appName => 'My Aves Framework';

  int get logLevel => 1;

  bool get isProduction {
    return false;
  }

  bool get isDebug {
    return true;
  }
}
