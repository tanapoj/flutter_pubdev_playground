part of 'translations.g.dart';

// Path: <root>
class TranslationsEn implements BaseTranslations {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEn.build({PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: _cardinalResolver = cardinalResolver,
		  _ordinalResolver = ordinalResolver;

	final PluralResolver? _cardinalResolver; // ignore: unused_field
	final PluralResolver? _ordinalResolver; // ignore: unused_field

	late final TranslationsEn _root = this; // ignore: unused_field

	// Translations
	late final TranslationsHomePageEn home_page = TranslationsHomePageEn._(_root);
	late final TranslationsTabPageEn tab_page = TranslationsTabPageEn._(_root);
	late final TranslationsSettingPageEn setting_page = TranslationsSettingPageEn._(_root);
}

// Path: home_page
class TranslationsHomePageEn {
	TranslationsHomePageEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Demo';
	String get menu_setting => 'Setting';
	String get tab_setting => 'Tab';
}

// Path: tab_page
class TranslationsTabPageEn {
	TranslationsTabPageEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Tab';
	String get tab_title_first => 'First';
	String get tab_title_second => 'Second';
	String get tab_title_setting => 'Setting';
}

// Path: setting_page
class TranslationsSettingPageEn {
	TranslationsSettingPageEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Setting';
	String get locale_en => 'English';
	String get locale_th => 'Thai';
	String get theme_1 => 'Theme I';
	String get theme_2 => 'Theme II';
}
