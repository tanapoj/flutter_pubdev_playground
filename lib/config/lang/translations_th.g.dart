part of 'translations.g.dart';

// Path: <root>
class TranslationsTh extends TranslationsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsTh.build({PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: _cardinalResolver = cardinalResolver,
		  _ordinalResolver = ordinalResolver,
		super.build();

	@override final PluralResolver? _cardinalResolver; // ignore: unused_field
	@override final PluralResolver? _ordinalResolver; // ignore: unused_field

	@override late final TranslationsTh _root = this; // ignore: unused_field

	// Translations
	@override late final TranslationsHomePageTh home_page = TranslationsHomePageTh._(_root);
	@override late final TranslationsTabPageTh tab_page = TranslationsTabPageTh._(_root);
	@override late final TranslationsSettingPageTh setting_page = TranslationsSettingPageTh._(_root);
}

// Path: home_page
class TranslationsHomePageTh extends TranslationsHomePageEn {
	TranslationsHomePageTh._(TranslationsTh root) : this._root = root, super._(root);

	@override final TranslationsTh _root; // ignore: unused_field

	// Translations
	@override String get title => 'เดโม่';
	@override String get menu_setting => 'ตั้งค่า';
	@override String get tab_setting => 'แท็บ';
}

// Path: tab_page
class TranslationsTabPageTh extends TranslationsTabPageEn {
	TranslationsTabPageTh._(TranslationsTh root) : this._root = root, super._(root);

	@override final TranslationsTh _root; // ignore: unused_field

	// Translations
	@override String get title => 'แท็บ';
	@override String get tab_title_first => 'หนึ่ง';
	@override String get tab_title_second => 'สอง';
	@override String get tab_title_setting => 'ตั้งค่า';
}

// Path: setting_page
class TranslationsSettingPageTh extends TranslationsSettingPageEn {
	TranslationsSettingPageTh._(TranslationsTh root) : this._root = root, super._(root);

	@override final TranslationsTh _root; // ignore: unused_field

	// Translations
	@override String get title => 'หน้าตั้งค่า';
	@override String get locale_en => 'อังกฤษ';
	@override String get locale_th => 'ไทย';
	@override String get theme_1 => 'ธีม ๑';
	@override String get theme_2 => 'ธีม ๒';
}
