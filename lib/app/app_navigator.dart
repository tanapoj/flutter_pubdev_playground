import 'package:flutter/widgets.dart';
import 'package:pubdev_playground/ui/main/home.dart';
import 'package:pubdev_playground/ui/main/startup.dart';

class AppNavigator {
  Widget startup() => StartupPage.builder();

  Widget home() => HomePage.builder();

  push() {}
}
