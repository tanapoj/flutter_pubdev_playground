import 'package:flutter/material.dart';
import 'package:pubdev_playground/app/environment.dart';
import 'package:pubdev_playground/app/index.dart';
import 'package:pubdev_playground/config/lang/translations.g.dart';

void main() {
  // var di = AppDi().withDefaultDependencies();
  Environment env = Environment();

  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();

  runApp(MainApplication(
    env: env,
  ));
}

class MainApplication extends StatelessWidget {
  final Environment env;

  const MainApplication({
    Key? key,
    required this.env,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      env: env,
      child: Builder(builder: (BuildContext context) {
        var env = AppProvider.of(context).env;
        var ui = AppProvider.of(context).ui;
        var nav = AppProvider.of(context).navigator;

        return MaterialApp(
          title: env.appName,
          theme: ui.themeData,
          home: nav.startup(),
        );
      }),
    );
  }
}
