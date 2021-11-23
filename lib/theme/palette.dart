import 'package:flutter/material.dart';

class Palette {
  Palette({this.isDark = false});

  final bool isDark;

  // Static color
  static const Color caption = Color(0xFF8C98A8);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFF039278);
  static const Color primary = Color(0xFF111B21);
  static const Color inputFill = Color(0xFFFAFAFA);
  static const Color accentBrand = Color.fromRGBO(249, 79, 79, 1.0);

  final Color _primaryBrandColor = primary;
  final Color _secondaryBrandColor = secondary;
  final Color _captionColor = caption;
  final Color _accentBrand = accentBrand;

  final Color _secondaryLightColor =  const Color(0xFF55D4BC);
  final Color _linkColor = const Color(0xFF3D81F3);
  final Color _annotationRegionColor = const Color(0xFFFAFAFA);
  final Color _scaffoldColor = white;
  final Color _whiteColor = const Color(0xFFFFFFFF);
  final Color _iconColor = primary;
  final Color _textColor = primary;
  final Color _secondarySplashColor = const Color(0xFF27A38D);
  final Color _secondaryHighLightColor = const Color(0xFF3BB49E);
  final Color _bottomAppBarColor = white;
  final Color _borderColor = const Color(0xFFF1F1F1);
  final Color _splashLightColor = const Color(0xFFEAEAEA);
  final Color _highLightLightColor = const Color(0xFFF1F1F1);
  final Color _inputFillColor = inputFill;
  final Color _disableButtonTextColor = const Color(0xFFD4D4D4);
  final Color _disableButtonColor = const Color(0xFFFAFAFA);
  final Color _disableButtonBorderColor = const Color(0xFFF1F1F1);
  final Color _shadowColor = const Color(0xFFF5F4F4);
  final Color _accentSplashColor = const Color.fromRGBO(253, 102, 102, 1.0);

  Color secondaryLightColor(double opacity) {
    return _secondaryLightColor.withOpacity(opacity);
  }

  Color accentSplashColor(double opacity) {
    return _accentSplashColor.withOpacity(opacity);
  }

  Color accentBrandColor(double opacity) {
    return _accentBrand.withOpacity(opacity);
  }

  Color linkColor(double opacity) {
    return _linkColor.withOpacity(opacity);
  }

  Color annotationRegionColor(double opacity) {
    return _annotationRegionColor.withOpacity(opacity);
  }

  Color shadowColor(double opacity) {
    return _shadowColor.withOpacity(opacity);
  }

  Color secondarySplashColor(double opacity) {
    return _secondarySplashColor.withOpacity(opacity);
  }

  Color secondaryHighLightColor(double opacity) {
    return _secondaryHighLightColor.withOpacity(opacity);
  }

  Color disableButtonTextColor(double opacity) {
    return _disableButtonTextColor.withOpacity(opacity);
  }

  Color disableButtonColor(double opacity) {
    return _disableButtonColor.withOpacity(opacity);
  }

  Color disableButtonBorderColor(double opacity) {
    return _disableButtonBorderColor.withOpacity(opacity);
  }

  Color inputFillColor(double opacity) {
    return _inputFillColor.withOpacity(opacity);
  }

  Color highLightLightColor(double opacity) {
    return _highLightLightColor.withOpacity(opacity);
  }

  Color splashLightColor(double opacity) {
    return _splashLightColor.withOpacity(opacity);
  }

  Color borderColor(double opacity) {
    return _borderColor.withOpacity(opacity);
  }

  Color bottomAppBarColor(double opacity) {
    return _bottomAppBarColor.withOpacity(opacity);
  }

  Color whiteColor(double opacity) {
    return _whiteColor.withOpacity(opacity);
  }

  Color textColor(double opacity) {
    return _textColor.withOpacity(opacity);
  }

  Color scaffoldColor(double opacity) {
    return _scaffoldColor.withOpacity(opacity);
  }

  Color primaryBrandColor(double opacity) {
    return _primaryBrandColor.withOpacity(opacity);
  }

  Color secondaryBrandColor(double opacity) {
    return _secondaryBrandColor.withOpacity(opacity);
  }

  Color captionColor(double opacity) {
    return _captionColor.withOpacity(opacity);
  }

  Color iconColor(double opacity) {
    return _iconColor.withOpacity(opacity);
  }
}
