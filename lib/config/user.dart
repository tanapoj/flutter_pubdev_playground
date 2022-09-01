import 'package:pubdev_playground/app/app_auth.dart';

class User extends AppUser {
  late int id;

  User(
    this.id,
  );

  @override
  String? serialize() {
    return null;
  }

  @override
  void unserialize(String? serializeString) {}
}
