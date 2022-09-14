import 'package:flutter/widgets.dart';
import 'package:pubdev_playground/_pub/aves/index.dart' as aves;

@immutable
class Environment extends aves.Environment {
  @override
  String get appName => 'MVVM Demo';

  @override
  int get logLevel => 1;

  @override
  bool get isProduction {
    return false;
  }

  @override
  bool get isDebug {
    return true;
  }

  bool get isUsingMockApiData => false;

  bool get isLogging => false;

  bool get isSystemLogging => false;

  bool get isEnableAds => true;

  String get baseUrl => 'https://test.co';
}
