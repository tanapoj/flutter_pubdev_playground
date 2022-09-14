import 'package:flutter/material.dart';
import 'package:pubdev_playground/app/index.dart' as app;
import 'package:pubdev_playground/common/log.dart';
import 'package:pubdev_playground/common/translate.dart';
import 'package:pubdev_playground/ui/pages/setting/setting.logic.dart';
import 'package:pubdev_playground/ui/widgets/none.dart';

class SettingView extends app.ComponentView<SettingPage> {
  const SettingView(
    SettingPage logic, {
    Key? key,
  }) : super(logic, key: key);

  @override
  Widget build(BuildContext context) {
    // return $watch(bloc.translator.$state, build: (_, AppLocale currentLocale) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tt.setting_page.title),
      ),
      body: body(),
    );
    // });
  }

  Widget body() {
    appLog.w('test StackTrace');
    appLog.e('test StackTrace');
    var cur = '${DateTime.now()}';
    AppLocale currentLocale = logic.translator.locale;
    return ListView(
      children: [
        ElevatedButton(
          onPressed: () {
            logic.rebuild();
          },
          child: Text('refresh $cur'),
        ),
        ListTile(
          title: Text(tt.setting_page.locale_en),
          trailing: Switch(
            value: currentLocale == AppLocale.en,
            onChanged: (select) {},
          ),
          onTap: () {
            logic.translator.switchLocale(AppLocale.en);
            appLog.d('locale=$tt');
          },
        ),
        ListTile(
          title: Text(tt.setting_page.locale_th),
          trailing: Switch(
            value: currentLocale == AppLocale.th,
            onChanged: (select) {},
          ),
          onTap: () {
            translator.switchLocale(AppLocale.th);
            appLog.d('locale=$tt');
          },
        ),
        ListTile(
          title: Text('Theme 1'),
          trailing: None(),
          onTap: () {
            ui.setTheme1();
          },
        ),
        ListTile(
          title: Text('Theme 2'),
          trailing: None(),
          onTap: () {
            ui.setTheme2();
          },
        ),
      ],
    );
  }
}
