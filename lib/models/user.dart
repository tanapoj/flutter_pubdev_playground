import 'package:pubdev_playground/_pub/aves/data/networks/network.dart';
import 'package:pubdev_playground/_pub/aves/index.dart';
import 'package:pubdev_playground/config/context.dart';

class User extends AvesUser {
  late int id;

  User(
    this.id,
  );

  @override
  Ctx get ctx => Ctx(user: this);

  @override
  String? serialize() {
    return null;
  }

  @override
  void unserialize(String? serializeString) {}

  void performNetworkRequest(Request request) {
    request.accessToken = accessToken;
  }
}
