import 'package:flutter/widgets.dart';
import 'package:pubdev_playground/app/index.dart';

@immutable
class DevEnvironment extends Environment {
  @override
  String get envName => 'dev env';

  @override
  String get appName => 'MVVM Demo';

  @override
  int get logLevel => 1;

  @override
  bool get isProduction {
    return false;
  }

  @override
  bool get isUsingDebugMode {
    return true;
  }

  bool get isUsingMockApiData => false;

  bool get isLogging => false;

  bool get isSystemLogging => false;

  String get baseUrl => 'https://test.co';

  @override
  String toString() {
    return 'DevEnvironment{\n'
        '   envName: $envName (isProduction: $isProduction, isUsingDebugMode: $isUsingDebugMode, isUsingMockApiData: $isUsingMockApiData)\n'
        '   appName: $appName\n'
        '   logLevel: $logLevel\n'
        '   baseUrl: $baseUrl\n'
        '}';
  }
}
