import 'package:pubdev_playground/_pub/aves/context.dart';
import 'package:pubdev_playground/_pub/flutter_live_data/index.dart';
import 'package:pubdev_playground/models/user.dart';

class AvesAuth {
  primaryInit() {}

  secondaryInit() async {}

  bool get isLogin => user != null || user is GuestUser;

  User? get user => $state.value;

  LiveDataSource<User?> $state = LiveDataSource(
    GuestUser(),
    dataSourceInterface: null,
  );

  setUser(User user) {
    $state.value = user;
  }

  unsetUser() {
    $state.value = null;
  }
}

abstract class AvesUser {
  String? serialize();

  void unserialize(String? serializeString);

  String get accessToken => '';

  bool get isGuest => this is GuestUser;

  AvesCtx get ctx => AvesCtx();
}

class GuestUser extends User {
  GuestUser() : super(-1);
}
