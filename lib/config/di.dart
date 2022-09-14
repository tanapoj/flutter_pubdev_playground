import 'package:pubdev_playground/_pub/aves/di.dart';

void setDefaultDependencies(AvesDi di) {
  di.singletonFactory<int>((c) {
    return 1;
  }, instanceName: 'app-version');
}
