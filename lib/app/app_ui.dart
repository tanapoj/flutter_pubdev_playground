import 'package:flutter/material.dart' as m;

class AppUi {
  init() {}

  m.ThemeData get themeData {
    return m.ThemeData(
      primarySwatch: m.Colors.green,
    );
  }

  final Text text = Text();
  final Color color = Color();
}

// Text

class Text {
  final TextSize size = TextSize();
}

class TextSize {
  final int header1 = 24;
}

// Color

class Color {
  final m.Color primary = m.Colors.green;
}
