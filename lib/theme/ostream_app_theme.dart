import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:stream/theme/material_color.dart';
import 'package:stream/theme/palette.dart';

class OStreamAppTheme {
  OStreamAppTheme({
  required this.isDark,
  }) : palette = Palette(isDark: isDark);

  final bool isDark;
  final Palette palette;

  ThemeData defaultTheme(BuildContext context) {
    return ThemeData(
      fontFamily: 'Poppins',
      // Settings
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: MaterialColorApp(),
      primaryColor: palette.secondaryBrandColor(1),
      primaryColorBrightness: Brightness.light,
      colorScheme: Theme.of(context).colorScheme.copyWith(
        secondary: palette.secondaryBrandColor(1),
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: palette.scaffoldColor(1),
      backgroundColor: palette.scaffoldColor(1),
      bottomAppBarColor: palette.scaffoldColor(1),
      cardColor: palette.scaffoldColor(1),
      dividerColor: Colors.transparent,
      focusColor: palette.secondaryHighLightColor(1),
      highlightColor: palette.secondaryHighLightColor(1),
      splashColor: palette.secondarySplashColor(1),
      textSelectionTheme: Theme.of(context).textSelectionTheme.copyWith(
        selectionColor: palette.secondaryBrandColor(1),
        cursorColor: palette.secondaryBrandColor(1),
        selectionHandleColor: palette.secondaryBrandColor(1),
      ),
      dialogBackgroundColor: palette.whiteColor(1),
      indicatorColor: palette.secondaryBrandColor(1),
      hintColor: palette.captionColor(1),
      errorColor: Colors.redAccent,
      iconTheme: Theme.of(context).iconTheme.copyWith(
        color: palette.iconColor(1),
        size: 16.0,
        opacity: 1,
      ),
      primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(
        color: palette.iconColor(1),
        size: 16.0,
        opacity: 1,
      ),
      tooltipTheme: Theme.of(context).tooltipTheme.copyWith(
        decoration: BoxDecoration(color: palette.textColor(1)),
      ),
      bottomAppBarTheme: Theme.of(context).bottomAppBarTheme.copyWith(
        color: palette.scaffoldColor(1),
        elevation: 0.0,
      ),
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
        color: palette.scaffoldColor(1),
        elevation: 0.0,
        actionsIconTheme: IconThemeData(
          color: palette.iconColor(1),
          size: 18.0,
          opacity: 1,
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) => palette.secondaryBrandColor(1)),
      ),
      inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
        isDense: true,
        filled: true,
        fillColor: palette.inputFillColor(1.0),
      ),
      textTheme: Theme.of(context).textTheme.copyWith(
        subtitle1: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
          color: palette.textColor(1),
        ),
        subtitle2: TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.w400,
          color: palette.textColor(1),
        ),
        headline1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
          color: palette.textColor(1),
        ),
        headline2: TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.w600,
          color: palette.secondaryBrandColor(1),
        ),
        caption: TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.w300,
          color: palette.captionColor(1),
        ),
      ),
    );
  }
}
