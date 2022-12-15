import 'package:flutter/src/widgets/framework.dart';
import 'package:pubdev_playground/_pub/aves/index.dart';
import 'package:pubdev_playground/ui/main/startup.dart';
import 'package:pubdev_playground/ui/pages/home/home.dart';

class AppNavigator extends AvesNavigator {
  @override
  Widget startup() => StartupPage.builder();

  @override
  Widget home() => HomePage.build();
}
