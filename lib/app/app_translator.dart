import 'package:pubdev_playground/_pub/flutter_live_data/index.dart';
import 'package:pubdev_playground/config/lang/translations.g.dart';

class _AppTranslations extends TranslationsEn {
  _AppTranslations() : super.build();
}

class AppTranslator extends _AppTranslations {
  AppTranslator() : super();

  AppLocale _locale = AppLocale.en;

  AppLocale get locale => _locale;

  LiveData<AppLocale> $state = LiveData(AppLocale.en);

  isEn() {
    return _locale == AppLocale.en;
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
