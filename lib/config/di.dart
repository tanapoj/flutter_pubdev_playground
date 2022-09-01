import 'package:pubdev_playground/app/app_di.dart';

extension DefaultSetting on AppDi {
  AppDi withDefaultDependencies() {
    singletonFactory<int>((c) {
      return 1234;
    }, instanceName: 'app-version');

    return this;
  }
}
