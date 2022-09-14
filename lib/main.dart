import 'package:flutter/material.dart';
import 'package:pubdev_playground/_pub/flutter_bloc_builder/index.dart';
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
      child: Builder(
        builder: (BuildContext context) {
          var provider = AppProvider.of(context);
          provider.primaryInit();
          return $watch(
            provider.$state,
            build: (context, value) {
              return MaterialApp(
                title: provider.env.appName,
                theme: provider.ui.theme.themeData,
                home: provider.navigator.startup(),
              );
            },
          );
        },
      ),
    );
  }
}
