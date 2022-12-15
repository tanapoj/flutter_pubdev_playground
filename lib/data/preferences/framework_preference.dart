import 'package:pubdev_playground/app/app_ui.dart';
import 'package:pubdev_playground/common/log.dart';
import 'package:pubdev_playground/config/lang/translations.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FrameworkPreference {
  static const String PREF_APP_LOCALE = 'pref-app-locale';
  static const String PREF_APP_THEME = 'pref-app-theme';

  // AppLocale

  Future<AppLocale> getAppLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var langCode = prefs.getString(PREF_APP_LOCALE) ?? 'en';
    appLog.d('FrameworkPreference.getAppLocale = $langCode');
    if (langCode == 'th') return AppLocale.th;
    return AppLocale.en;
  }

  void setAppLocale(AppLocale locale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? langCode;
    if (locale == AppLocale.en) langCode = 'en';
    if (locale == AppLocale.th) langCode = 'th';
    appLog.d('FrameworkPreference.setAppLocale = $langCode');
    prefs.setString(PREF_APP_LOCALE, langCode ?? 'en');
  }

  // AppLocale

  Future<AppTheme> getAppTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var themeCode = prefs.getString(PREF_APP_THEME) ?? '';
    appLog.d('FrameworkPreference.getAppTheme = $themeCode');
    if (themeCode == '2') return AppTheme2();
    return AppTheme();
  }

  void setAppTheme(AppTheme theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? themeCode;
    if (theme is AppTheme2) themeCode = '2';
    appLog.d('FrameworkPreference.setAppTheme = $themeCode');
    prefs.setString(PREF_APP_THEME, themeCode ?? '1');
  }
}
