import 'package:flutter/material.dart';
import 'package:pubdev_playground/_pub/flutter_live_data/index.dart';
import 'package:pubdev_playground/app/index.dart' as app;
import 'package:pubdev_playground/common/log.dart';
import 'package:pubdev_playground/common/translate.dart';

class SettingPage extends app.ComponentLogic {
  @override
  String get name => 'setting';

  late final LiveData<int> $counter = LiveData(0, name: '$name.counter').owner(this);
  late final LiveData<String?> $label = LiveData(null, name: '$name.label').owner(this);

  SettingPage._({
    Key? key,
    required Widget Function(app.ComponentLogic) builder,
  }) : super(key: key, builder: builder);

  factory SettingPage.builder() {
    return SettingPage._(
      builder: (component) => SettingView(
        component as SettingPage,
      ),
    );
  }
}

class SettingView extends app.ComponentView<SettingPage> {
  const SettingView(
    SettingPage component, {
    Key? key,
  }) : super(component, key: key);

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
      ],
    );
  }
}
