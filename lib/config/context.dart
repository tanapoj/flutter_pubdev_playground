import 'package:pubdev_playground/_pub/aves/architecture/context.dart';
import 'package:pubdev_playground/_pub/aves/data/networks/network.dart';
import 'package:pubdev_playground/app/index.dart';
import 'package:pubdev_playground/model/user.dart';

class FlowContext extends AvesContext {
  final User? user;
  final Environment? env;

  FlowContext({
    this.user,
    this.env,
  });

  factory FlowContext.from(FlowContext? ctx) {
    return FlowContext(
      user: ctx?.user,
      env: ctx?.env,
    );
  }

  FlowContext operator +(FlowContext next) {
    if (next is! FlowContext) return this;
    return FlowContext(
      user: user ?? next.user,
      env: env ?? next.env,
    );
  }

  @override
  P perform<P>(P performable) {
    super.perform(performable);

    if (performable is Request && user != null) {
      user!.performNetworkRequest(performable);
    }

    if (performable is Request && env != null) {
      performable.baseUrl = env!.baseUrl;
    }

    if (performable is Performable && performable.when(this)) {
      performable.action.call(this);
    }

    return performable;
  }
}

class Performable {
  final bool Function(FlowContext ctx) when;
  final void Function(FlowContext ctx) action;

  Performable({
    required this.when,
    required this.action,
  });
}
