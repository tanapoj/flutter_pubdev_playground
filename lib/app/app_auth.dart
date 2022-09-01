import 'package:pubdev_playground/_pub/flutter_live_data/index.dart';
import 'package:pubdev_playground/config/user.dart';

class AppAuth {
  bool get isLogin => user != null;

  User? get user => $state.value;

  LiveDataSource<User?> $state = LiveDataSource(
    null,
    dataSourceInterface: createDataSourceInterface<User>(
      loadValueAction: () async {
        return Future.value(User(1));
      },
      onValueUpdatedAction: (User value, bool hasChange) async {
        //
      },
    ),
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
