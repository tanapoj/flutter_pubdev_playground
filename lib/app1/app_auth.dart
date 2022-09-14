import 'package:pubdev_playground/_pub/flutter_live_data/index.dart';
import 'package:pubdev_playground/models/user.dart';

class AppAuth {
  init() {}

  bool get isLogin => user != null;

  User? get user => $state.value;

  LiveDataSource<User?> $state = LiveDataSource(
    null,
    dataSourceInterface: null,
  );

  setUser(User user) {
    $state.value = user;
  }

  unsetUser() {
    $state.value = null;
  }
}

abstract class AppUser {
  String? serialize();

  void unserialize(String? serializeString);
}
