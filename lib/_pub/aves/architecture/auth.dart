import 'package:flutter_live_data/index.dart';
import 'package:pubdev_playground/_pub/aves/architecture/context.dart';
// import 'package:pubdev_playground/model/user.dart';

class AvesAuth<AppUser> {
  syncInit() {}

  asyncInit() async {
    return Future.value(null);
  }

  bool get isLogin => user != null; // || user is GuestUser;

  AppUser? get user => $state.value;

  LiveDataSource<AppUser?> $state = LiveDataSource(
    null, // GuestUser(),
    dataSourceInterface: null,
  );

  setUser(AppUser user) {
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

  // TODO
  // bool get isGuest => this is GuestUser;

  AvesContext get context => AvesContext();
}

// TODO:
// class GuestUser extends AvesUser {
//   GuestUser() : super(-1);
//
//   @override
//   String? serialize() {
//     // TODO: implement serialize
//     throw UnimplementedError();
//   }
//
//   @override
//   void unserialize(String serializeString) {
//     // TODO: implement unserialize
//   }
// }

void inception(
  AvesUser user, {
  required void Function(AvesUser prevUser, AvesUser currentUser) perform,
}) {}
