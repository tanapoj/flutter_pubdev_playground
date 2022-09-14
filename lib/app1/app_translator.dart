import 'package:pubdev_playground/_pub/flutter_live_data/index.dart';
import 'package:pubdev_playground/config/lang/translations.g.dart';
import 'package:pubdev_playground/data/preferences/framework_preference.dart';

class _AppTranslations extends TranslationsEn {
  _AppTranslations() : super.build();
}

class AppTranslator extends _AppTranslations {
  final FrameworkPreference _pref = FrameworkPreference();

  AppTranslator() : super();

  AppLocale _locale = AppLocale.en;

  AppLocale get locale => _locale;

  LiveDataSource<AppLocale> $state = LiveDataSource(
    AppLocale.en,
    dataSourceInterface: null,
  );

  init() async {
    setLocale(await _pref.getAppLocale());
    $state.dataSourceInterface = createDataSourceInterface<AppLocale>(
      loadValueAction: null,
      onValueUpdatedAction: (AppLocale value, bool hasChange) async {
        _pref.setAppLocale(value);
      },
    );
  }

  isEn() {
    return _locale == AppLocale.en;
  }

  setLocale(AppLocale locale) {
    _locale = locale;
  }

  switchLocale(AppLocale locale) {
    _locale = locale;
    if (_locale == AppLocale.en) {
      LocaleSettings.instance.setLocale(AppLocale.en);
      $state.value = _locale;
    }
    if (_locale == AppLocale.th) {
      LocaleSettings.instance.setLocale(AppLocale.th);
      $state.value = _locale;
    }
  }
}
