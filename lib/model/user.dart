import 'package:pubdev_playground/_pub/aves/data/networks/network.dart';
import 'package:pubdev_playground/_pub/aves/index.dart';
import 'package:pubdev_playground/config/context.dart';

class User extends AvesUser {
  late int id;

  User(
    this.id,
  );

  @override
  FlowContext get context => FlowContext(user: this);

  @override
  String? serialize() {
    return null;
  }

  bool get isGuest => false;

  @override
  void unserialize(String? serializeString) {}

  void performNetworkRequest(Request request) {
    request.accessToken = accessToken;
  }

  @override
  String toString() {
    return 'User{id: $id}';
  }
}
