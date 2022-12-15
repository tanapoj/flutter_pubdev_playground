import 'package:pubdev_playground/_pub/aves/architecture/auth.dart';
import 'package:pubdev_playground/_pub/aves/facade/flow_interceptor.dart';

class AvesApp {
  FlowInterceptor flow(){
    return FlowInterceptor();
  }

  AvesAuth auth(){
    return AvesAuth();
  }
}

extension on AvesApp {
  T apply<T>(T Function(AvesApp prev, AvesApp current) runner) {

    return runner(this, this);
  }
}
