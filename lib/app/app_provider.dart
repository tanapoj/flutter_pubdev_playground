import 'package:flutter/material.dart' as m;
import 'package:pubdev_playground/app/app_auth.dart';
import 'package:pubdev_playground/app/app_navigator.dart';
import 'package:pubdev_playground/app/app_translator.dart';
import 'package:pubdev_playground/app/app_ui.dart';
import 'package:pubdev_playground/app/environment.dart';

// ignore: must_be_immutable
class AppProvider extends m.InheritedWidget {
  final Environment env;
  AppNavigator navigator = AppNavigator();
  AppTranslator translator = AppTranslator();
  AppUi ui = AppUi();
  AppAuth auth = AppAuth();

  AppProvider({
    m.Key? key,
    required m.Widget child,
    required this.env,
  }) : super(key: key, child: child);

  static AppProvider of(m.BuildContext context) {
    final AppProvider? result = context.dependOnInheritedWidgetOfExactType<AppProvider>();
    assert(result != null, 'No AppProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppProvider old) =>
      env != old.env && navigator != old.navigator && translator != old.translator && ui != old.ui && auth != old.auth;

  init() {
    navigator.init();
    translator.init();
    ui.init();
    auth.init();
  }
}

// class AppBlocDependencies {
//   AppBlocNavigator? appNavigator;
//   AppBlocTranslator? appTranslator;
//   AppBlocUi? appUi;
// }

// class FrogColor extends InheritedWidget {
//   const FrogColor({
//     Key? key,
//     required Widget child,
//   }) : super(key: key, child: child);
//
//   final Color color = Colors.green;
//
//   static FrogColor of(BuildContext context) {
//     final FrogColor? result = context.dependOnInheritedWidgetOfExactType<FrogColor>();
//     assert(result != null, 'No FrogColor found in context');
//     return result!;
//   }
//
//   @override
//   bool updateShouldNotify(FrogColor old) => color != old.color;
// }
