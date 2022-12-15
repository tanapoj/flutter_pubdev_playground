import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:pubdev_playground/_pub/aves/architecture/di.dart';
import 'package:pubdev_playground/config/di.config.dart';

void setDefaultDependencies(AvesDi di) {
  di.singletonFactory<int>((c) {
    return 1;
  }, instanceName: 'app-version');
}

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
void configureDependencies() => $initGetIt(getIt);

// Test

@injectable
class ServiceA {}

@injectable
class ServiceB {
  ServiceB(ServiceA serviceA);
}
