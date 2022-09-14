import 'package:pubdev_playground/common/log.dart';
import 'package:pubdev_playground/config/lang/translations.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FrameworkPreference {
  static const String PREF_APP_LOCALE = 'pref-app-locale';

  // AppLocale

  Future<AppLocale> getAppLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var langCode = prefs.getString(PREF_APP_LOCALE) ?? 'en';
    appLog.d(':: get PREF_APP_LOCALE=$langCode');
    if (langCode == 'en') return AppLocale.en;
    if (langCode == 'th') return AppLocale.th;
    throw 'Language Code Invalid';
  }

  void setAppLocale(AppLocale locale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? langCode;
    if (locale == AppLocale.en) langCode = 'en';
    if (locale == AppLocale.th) langCode = 'th';
    appLog.d(':: set PREF_APP_LOCALE=$langCode');
    prefs.setString(PREF_APP_LOCALE, langCode ?? 'en');
  }
}
