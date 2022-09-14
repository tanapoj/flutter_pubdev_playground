import 'package:pubdev_playground/_pub/flutter_live_data/index.dart';
import 'package:pubdev_playground/config/lang/translations.g.dart';
import 'package:pubdev_playground/data/preferences/framework_preference.dart';

class _AvesTranslations extends TranslationsEn {
  _AvesTranslations() : super.build();
}

class AvesTranslator extends _AvesTranslations {
  final FrameworkPreference _pref = FrameworkPreference();

  AvesTranslator() : super();

  AppLocale _locale = AppLocale.en;

  AppLocale get locale => _locale;

  LiveDataSource<AppLocale> $state = LiveDataSource(
    AppLocale.en,
    dataSourceInterface: null,
  );

  primaryInit() {}

  secondaryInit() async {
    setLocale(await _pref.getAppLocale());
    $state.dataSourceInterface = createDataSourceInterface<AppLocale>(
      loadValueAction: null,
      onValueUpdatedAction: (AppLocale value, bool hasChange) async {
        _pref.setAppLocale(value);
      },
    );
    return Future.value(null);
  }

  setLocale(AppLocale locale) {
    _locale = locale;
  }
}
