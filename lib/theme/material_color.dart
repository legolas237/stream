import 'package:flutter/material.dart';

import 'package:stream/config/hooks.dart';
import 'package:stream/theme/palette.dart';

class MaterialColorApp extends MaterialColor {
  static final MaterialColorApp _singleton = MaterialColorApp._internal(
    _primaryColor,
    _colorsMap,
  );

  factory MaterialColorApp() {
    return _singleton;
  }

  MaterialColorApp._internal(int primary, Map<int, Color> swatch)
      : super(primary, swatch);

  static final int _primaryColor = Palette.primary.value;
  static final Map<int, Color> _colorsMap = {
    50: Hooks.tintColor(Palette.primary, 0.9),
    100: Hooks.tintColor(Palette.primary, 0.8),
    200: Hooks.tintColor(Palette.primary, 0.6),
    300: Hooks.tintColor(Palette.primary, 0.4),
    400: Hooks.tintColor(Palette.primary, 0.2),
    500: Palette.primary,
    600: Hooks.shadeColor(Palette.primary, 0.1),
    700: Hooks.shadeColor(Palette.primary, 0.2),
    800: Hooks.shadeColor(Palette.primary, 0.3),
    900: Hooks.shadeColor(Palette.primary, 0.4),
  };
}
