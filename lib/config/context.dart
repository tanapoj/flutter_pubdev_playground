import 'package:pubdev_playground/_pub/aves/context.dart';
import 'package:pubdev_playground/_pub/aves/data/networks/network.dart';
import 'package:pubdev_playground/app/index.dart';
import 'package:pubdev_playground/models/user.dart';

class Ctx extends AvesCtx {
  final User? user;
  final Environment? env;

  Ctx({
    this.user,
    this.env,
  });

  @override
  Ctx operator +(Ctx next) {
    if (next is! Ctx) return this;
    return Ctx(
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
  final bool Function(Ctx ctx) when;
  final void Function(Ctx ctx) action;

  Performable({
    required this.when,
    required this.action,
  });
}
