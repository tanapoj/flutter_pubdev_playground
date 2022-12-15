import 'package:flutter/material.dart' as m;
import 'package:pubdev_playground/_pub/aves/architecture/ui.dart';
import 'package:flutter_live_data/index.dart';
import 'package:pubdev_playground/app/app_provider.dart';
import 'package:pubdev_playground/data/preferences/framework_preference.dart';

class AppUi extends AvesUi {
  final FrameworkPreference _pref = FrameworkPreference();
  late final LiveDataSource<AppTheme> $state = LiveDataSource(
    AppTheme(),
    verifyDataChange: true,
  );

  AppUi(App provider) {
    $state.listen((value) {
      provider.$state.tick();
    });
  }

  @override
  asyncInit() async {
    setTheme(await _pref.getAppTheme());
    $state.dataSourceInterface = createDataSourceInterface<AppTheme>(
      loadValueAction: null,
      onValueUpdatedAction: (AppTheme value, bool hasChange) async {
        _pref.setAppTheme(value);
      },
    );
  }

  setTheme(AppTheme theme) {
    $state.value = theme;
  }

  useTheme1() {
    $state.value = AppTheme();
  }

  useTheme2() {
    $state.value = AppTheme2();
  }

  AppTheme get theme {
    return $state.value;
  }

  AppStyle get style {
    return AppStyle();
  }

  bool get isUsingTheme1 => !isUsingTheme2;

  bool get isUsingTheme2 => $state.value is AppTheme2;

  @override
  String toString() {
    return 'AppUi{${$state}}';
  }
}

class AppTheme {
  m.ThemeData get themeData {
    return m.ThemeData(
      primarySwatch: m.Colors.green,
    );
  }

  @override
  String toString() {
    return 'AppTheme{light theme}';
  }
}

class AppTheme2 extends AppTheme {
  @override
  m.ThemeData get themeData {
    return m.ThemeData(
      primarySwatch: m.Colors.purple,
    );
  }

  @override
  String toString() {
    return 'AppTheme{dark theme}';
  }
}

class AppStyle {
  final _Text text = _Text();
  final _Color color = _Color();
  final _Dimen dimen = _Dimen();
}

// Text

class _Text {
  final _TextSize size = _TextSize();
  final m.TextStyle textStyle1 = const m.TextStyle(
    color: m.Colors.green,
  );
  final m.TextStyle textStyle2 = const m.TextStyle(
    color: m.Colors.cyan,
  );
}

class _TextSize {
  final int header1 = 24;
}

// Color

class _Color {
  final m.Color primary = m.Colors.green;
}

// dimension

class _Dimen {
  final double s = 0;
}
