import 'package:flutter/material.dart';

import 'package:stream/theme/ostream_app_theme.dart';

class ThemeProvider extends InheritedWidget {
  const ThemeProvider({
    Key? key,
    required Widget child,
    required this.appTheme,
  })  : super(key: key, child: child);

  final OStreamAppTheme appTheme;

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) {
    return appTheme != oldWidget.appTheme;
  }

  static ThemeProvider? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
}
