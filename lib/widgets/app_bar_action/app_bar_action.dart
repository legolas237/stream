import 'package:flutter/material.dart';

import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class AppBarActionWidget extends StatelessWidget {
  AppBarActionWidget({
    Key? key,
    required this.icon,
    this.onPressed,
    this.splashColor,
    this.highLightColor,
    this.color = Colors.transparent,
  }) : super(key: key);

  late Palette palette;

  final Icon icon;
  final Color color;
  final VoidCallback? onPressed;
  final Color? splashColor;
  final Color? highLightColor;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    return Material(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(50.0),
      color: Colors.transparent,
      child: IconButton(
        color: color,
        padding: const EdgeInsets.all(0.0),
        onPressed: () {
          if (onPressed != null) {
            onPressed!();
          }
        },
        icon: icon,
        highlightColor: highLightColor ?? palette.secondaryHighLightColor(1),
        hoverColor: highLightColor ?? palette.secondaryHighLightColor(1),
        splashColor: splashColor ?? palette.secondarySplashColor(1),
      ),
    );
  }

  static Icon buildIcon({required IconData icon, required Color color, double size = 20.0,}) {
    return Icon(
      icon,
      color: color,
      size: size,
    );
  }
}
