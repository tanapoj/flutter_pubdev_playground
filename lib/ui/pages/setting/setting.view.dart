import 'package:flutter/material.dart';
import 'package:pubdev_playground/app/app_ui.dart';
import 'package:pubdev_playground/app/index.dart' as app;
import 'package:pubdev_playground/common/log.dart';
import 'package:pubdev_playground/common/translate.dart';
import 'package:pubdev_playground/ui/pages/setting/setting.logic.dart';
import 'package:pubdev_playground/ui/widgets/none.dart';

class SettingView extends app.View<SettingPage> {
  final bool onlyContent;

  const SettingView(
    SettingPage logic, {
    this.onlyContent = false,
    Key? key,
  }) : super(logic, key: key);

  @override
  Widget build(BuildContext context) {
    if (onlyContent) {
      return body();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(tt.setting_page.title),
      ),
      body: body(),
    );
    // });
  }

  TranslationsSettingPageEn get _t => tt.setting_page;

  Widget body() {
    // appLog.w('test StackTrace');
    // appLog.e('test StackTrace');
    var cur = '${DateTime.now()}';
    AppLocale currentLocale = logic.translator.locale;
    AppTheme theme = logic.ui.theme;
    return ListView(
      children: [
        // ElevatedButton(
        //   onPressed: () {
        //     logic.rebuild();
        //   },
        //   child: Text('refresh $cur'),
        // ),
        Card(
          child: Column(
            children: [
              ListTile(
                title: Text(_t.locale_en),
                trailing: translator.isUsingEnglish ? const Icon(Icons.check) : None(),
                onTap: () {
                  translator.useEnglish();
                  appLog.d('locale=$tt');
                },
              ),
              ListTile(
                title: Text(tt.setting_page.locale_th),
                trailing: translator.isUsingThai ? const Icon(Icons.check) : None(),
                onTap: () {
                  translator.useThai();
                  appLog.d('locale=$tt');
                },
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            children: [
              ListTile(
                title: Text(tt.setting_page.theme_1),
                trailing: ui.isUsingTheme1 ? const Icon(Icons.check) : None(),
                onTap: () {
                  ui.useTheme1();
                },
              ),
              ListTile(
                title: Text(
                  tt.setting_page.theme_2,
                  style: ui.style.text.textStyle1.merge(ui.style.text.textStyle2),
                ),
                trailing: ui.isUsingTheme2 ? const Icon(Icons.check) : None(),
                onTap: () {
                  ui.style.text.size.header1;
                  ui.useTheme2();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
