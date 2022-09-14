import 'package:flutter/material.dart' as m;
import 'package:pubdev_playground/_pub/aves/ui.dart';
import 'package:pubdev_playground/_pub/flutter_live_data/index.dart';
import 'package:pubdev_playground/app/app_provider.dart';

class AppUi extends AvesUi {
  late final LiveData<AppTheme> $state = LiveData(AppTheme());

  AppUi(AppProvider provider) {
    $state.listen((value) {
      provider.$state.tick();
    });
  }

  setTheme1() {
    $state.value = AppTheme();
  }

  setTheme2() {
    $state.value = AppTheme2();
  }

  AppTheme get theme {
    return AppTheme();
  }

  AppStyle get style {
    return AppStyle();
  }
}

class AppTheme {
  m.ThemeData get themeData {
    return m.ThemeData(
      primarySwatch: m.Colors.green,
    );
  }
}

class AppTheme2 extends AppTheme {
  @override
  m.ThemeData get themeData {
    return m.ThemeData(
      primarySwatch: m.Colors.purple,
    );
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
