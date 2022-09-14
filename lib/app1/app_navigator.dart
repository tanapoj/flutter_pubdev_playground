import 'package:flutter/widgets.dart';
import 'package:pubdev_playground/ui/pages/home/home.dart';
import 'package:pubdev_playground/ui/main/startup.dart';

class AppNavigator {
  init() {}

  Widget startup() => StartupPage.builder();

  Widget home() => HomePage.builder();

  push() {}
}
