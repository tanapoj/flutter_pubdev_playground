import 'package:pubdev_playground/_pub/aves/index.dart';
import 'package:pubdev_playground/config/lang/translations.g.dart';

class AppTranslator extends AvesTranslator {
  AppTranslator() : super();

  isUsingEnglish() {
    return locale == AppLocale.en;
  }

  isUsingThai() {
    return locale == AppLocale.th;
  }

  switchLocale(AppLocale _locale) {
    setLocale(_locale);

    if (locale == AppLocale.en) {
      LocaleSettings.instance.setLocale(AppLocale.en);
      $state.value = locale;
    }
    if (locale == AppLocale.th) {
      LocaleSettings.instance.setLocale(AppLocale.th);
      $state.value = locale;
    }
  }
}
