import 'package:get_it/get_it.dart';

class AppDi {
  final _getIt = GetIt.I;

  T get<T extends Object>([String? instanceName]) => _getIt.get<T>(instanceName: instanceName);

  void singletonFactory<T extends Object>(T Function(AppDi) factory, {String? instanceName}) {
    try {
      var i = _getIt.get<T>();
      _getIt.unregister(instance: i, instanceName: instanceName);
    } catch (e) {}
    try {
      _getIt.registerLazySingleton(() {
        return factory(this);
      }, instanceName: instanceName);
    } catch (e) {}
  }

  void singleton<T extends Object>(T instance, {String? instanceName}) {
    try {
      try {
        var i = _getIt.get<T>(instanceName: instanceName);
        _getIt.unregister<T>(instance: i, instanceName: instanceName);
      } catch (e) {}
      _getIt.registerSingleton<T>(instance, instanceName: instanceName);
    } catch (e) {}
  }

//  void test() {
//    debugPrint('_getIt.factories = ${_getIt.factories}');
//    for (var x in _getIt.factories.keys) {
//      debugPrint('$x :: ${_getIt.factories[x]}');
//    }
//  }
}

class Di {
  static Di? _singleton;

  factory Di([AppDi? container]) {
    _singleton ??= Di._internal();
    if (container != null) _singleton!.container = container;
    return _singleton!;
  }

  Di._internal();

  AppDi? container;
}

T inject<T extends Object>([String? instanceName]) => Di().container!.get<T>(instanceName);

//EnvironmentConfig injectEnv() => Di().container.get<EnvironmentConfig>('env');
