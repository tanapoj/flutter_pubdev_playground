import 'package:flutter/widgets.dart';
import 'package:pubdev_playground/_pub/aves/index.dart';
import 'package:flutter_live_data/index.dart';
import 'package:pubdev_playground/app/app_auth.dart';
import 'package:pubdev_playground/app/app_navigator.dart';
import 'package:pubdev_playground/app/app_translator.dart';
import 'package:pubdev_playground/app/app_ui.dart';
import 'package:pubdev_playground/common/log.dart';
import 'package:pubdev_playground/model/user.dart';

// ignore: must_be_immutable
class App extends AvesProvider {
  App({
    super.key,
    required super.child,
    required Environment env,
  }) : super(env: env);

  late final LiveData<App> $state = LiveData(this);
  late AppNavigator _navigator = AppNavigator();
  late AppTranslator _translator = AppTranslator(this);
  late AppUi _ui = AppUi(this);
  late AppAuth<User> _auth = AppAuth<User>();

  AppNavigator get navigator => _navigator;

  AppTranslator get translator => _translator;

  AppUi get ui => _ui;

  AppAuth<User> get auth => _auth;

  void set({
    AppNavigator? navigator,
    AppTranslator? translator,
    AppUi? ui,
    AppAuth<User>? auth,
  }) {
    if (navigator != null) {
      _navigator = navigator;
    }
    if (translator != null) {
      _translator = translator;
    }
    if (ui != null) {
      _ui = ui;
    }
    if (auth != null) {
      _auth = auth;
    }
  }

  static App? instance;

  static App of(BuildContext context) {
    final AvesProvider? result = context.dependOnInheritedWidgetOfExactType<App>();
    assert(result != null || result is! App, 'No AppProvider found in context');
    return instance = result! as App;
  }

  @override
  bool updateShouldNotify(App oldWidget) =>
      env != oldWidget.env &&
      navigator != oldWidget.navigator &&
      translator != oldWidget.translator &&
      ui != oldWidget.ui &&
      auth != oldWidget.auth;

  @override
  syncInit() {
    sysLog.d('AppProvider run syncInit ... start');
    navigator.syncInit();
    ui.syncInit();
    auth.syncInit();
    translator.syncInit();
    sysLog.d('AppProvider run syncInit ... done');
  }

  @override
  asyncInit() async {
    sysLog.d('AppProvider run asyncInit ... start');
    await Future.wait(<Future>[
      navigator.asyncInit(),
      ui.asyncInit(),
      auth.asyncInit(),
      translator.asyncInit(),
    ]);
    sysLog.d('AppProvider run asyncInit ... done');
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppProvider{\n'
        '   navigator: $navigator\n'
        '   translator: $translator\n'
        '   ui: $ui\n'
        '   auth: $auth\n'
        '}';
  }
}
