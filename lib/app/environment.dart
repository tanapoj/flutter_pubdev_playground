import 'package:flutter/widgets.dart';

@immutable
class Environment {
  String get appName => 'MVVM Demo';

  final int logLevel = 1;
  final bool isDebugMode = false;

  bool get isProduction {
    return !isDebug;
  }

  bool get isDebug {
    return isDebugMode;
  }

  final bool isUsingMockApiData = false;

  final bool isLogging = false;

  final bool isSystemLogging = false;

  final bool isEnableAds = true;
}
