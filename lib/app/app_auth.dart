import 'package:pubdev_playground/_pub/aves/index.dart';
import 'package:pubdev_playground/config/context.dart';

class AppAuth<User> extends AvesAuth<User> {
  FlowContext get ctx => FlowContext();

  @override
  String toString() {
    return 'AppAuth{$user}';
  }
}
