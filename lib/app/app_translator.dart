import 'package:pubdev_playground/_pub/aves/index.dart';
import 'package:pubdev_playground/app/app_provider.dart';
import 'package:pubdev_playground/config/lang/translations.g.dart';

class AppTranslator extends AvesTranslator {
  AppTranslator(App provider) : super() {
    $state.listen((value) {
      provider.$state.tick();
    });
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

  void useEnglish() {
    switchLocale(AppLocale.en);
  }

  void useThai() {
    switchLocale(AppLocale.th);
  }

  bool get isUsingEnglish => locale == AppLocale.en;

  bool get isUsingThai => locale == AppLocale.th;

  @override
  String toString() {
    return 'AppTranslator{${$state.value}}';
  }
}
