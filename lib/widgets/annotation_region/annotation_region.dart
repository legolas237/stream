import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AnnotationRegionWidget extends StatelessWidget {
  const AnnotationRegionWidget({
    Key? key,
    required this.color,
    required this.brightness,
    required this.child,
  }) : super(key: key);

  final Color color;
  final Brightness brightness;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: color,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: brightness,
      systemNavigationBarContrastEnforced: false,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemTheme,
      child: child,
    );
  }
}