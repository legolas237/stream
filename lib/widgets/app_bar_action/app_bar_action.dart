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
  }) : super(key: key);

  late Palette palette;

  final Icon icon;
  final VoidCallback? onPressed;
  final Color? splashColor;
  final Color? highLightColor;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    return Material(
      shape: const CircleBorder(),
      color: Colors.transparent,
      child: IconButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed!();
          }
        },
        icon: icon,
        highlightColor: highLightColor ?? palette.highLightLightColor(1),
        hoverColor: highLightColor ?? palette.highLightLightColor(1),
        splashColor: splashColor ?? palette.splashLightColor(1),
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
