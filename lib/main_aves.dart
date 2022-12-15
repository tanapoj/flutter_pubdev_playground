import 'package:flutter/material.dart';
import 'package:bloc_builder/index.dart';
import 'package:pubdev_playground/app/index.dart';
import 'package:pubdev_playground/common/log.dart';
import 'package:pubdev_playground/config/lang/translations.g.dart';
import 'package:pubdev_playground/config/env/dev.dart';

void main() {
  Environment env = DevEnvironment();

  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();

  sysLog.i('run app, using environment: $env');

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
  Widget build(BuildContext _context) {
    sysLog.i('build MainApplication');
    return App(
      env: env,
      child: Builder(
        builder: (BuildContext context) {
          sysLog.i('build AppProvider');
          var app = App.of(context);
          app.syncInit();
          return $watch(
            app.$state,
            build: (context, _) {
              sysLog.i('build-render MaterialApp');
              return MaterialApp(
                title: app.env.appName,
                theme: app.ui.theme.themeData,
                home: app.navigator.startup(),
              );
            },
          );
        },
      ),
    );
  }
}
