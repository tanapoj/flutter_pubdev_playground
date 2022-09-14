import 'package:flutter/material.dart';
import 'package:pubdev_playground/_pub/flutter_live_data/index.dart';
import 'package:pubdev_playground/app/index.dart' as app;
import 'package:pubdev_playground/ui/pages/setting/setting.view.dart';

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
