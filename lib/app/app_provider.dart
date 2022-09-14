import 'package:flutter/widgets.dart';
import 'package:pubdev_playground/_pub/aves/index.dart';
import 'package:pubdev_playground/_pub/flutter_live_data/index.dart';
import 'package:pubdev_playground/app/app_auth.dart';
import 'package:pubdev_playground/app/app_navigator.dart';
import 'package:pubdev_playground/app/app_translator.dart';
import 'package:pubdev_playground/app/app_ui.dart';
import 'package:pubdev_playground/common/log.dart';

// ignore: must_be_immutable
class AppProvider extends AvesProvider {
  AppProvider({
    super.key,
    required super.child,
    required Environment env,
  }) : super(env: env);

  late final LiveData<AppProvider> $state = LiveData(this);
  late AppNavigator navigator = AppNavigator();
  late AppTranslator translator = AppTranslator();
  late AppUi ui = AppUi(this);
  late AppAuth auth = AppAuth();

  static AppProvider of(BuildContext context) {
    final AvesProvider? result = context.dependOnInheritedWidgetOfExactType<AppProvider>();
    assert(result != null || result is! AppProvider, 'No AppProvider found in context');
    return result! as AppProvider;
  }

  @override
  bool updateShouldNotify(AppProvider oldWidget) =>
      env != oldWidget.env &&
      navigator != oldWidget.navigator &&
      translator != oldWidget.translator &&
      ui != oldWidget.ui &&
      auth != oldWidget.auth;

  @override
  primaryInit() {
    navigator.primaryInit();
    ui.primaryInit();
    auth.primaryInit();
    translator.primaryInit();
  }

  @override
  secondaryInit() async {
    appLog.d('AppProvider.secondaryInit() 1');
    await Future.wait(<Future>[
      navigator.secondaryInit(),
      ui.secondaryInit(),
      auth.secondaryInit(),
      translator.secondaryInit(),
    ]);
    appLog.d('AppProvider.secondaryInit() 2');
  }
}
