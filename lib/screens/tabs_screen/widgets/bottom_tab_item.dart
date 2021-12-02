import 'package:flutter/material.dart';

import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class BottomTabItemWidget extends StatelessWidget {
  BottomTabItemWidget({
    Key? key,
    required this.icon,
    required this.selected,
    required this.callback,
    required this.width,
  }) : super(key: key);

  late Palette palette;

  final IconData icon;
  final bool selected;
  final double width;

  final Function callback;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: palette.splashLightColor(1),
        highlightColor: palette.highLightLightColor(1),
        hoverColor: palette.highLightLightColor(1),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18.0,
                color: selected
                    ? palette.secondaryBrandColor(1)
                    : palette.captionColor(0.8),
              ),
              const SizedBox(height: 8.0),
              Container(
                height: 1.6,
                width: 14.0,
                decoration: BoxDecoration(
                  color: selected
                      ? palette.secondaryBrandColor(1)
                      : Colors.transparent,
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(4.0),),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          if (!selected) {
            callback();
          }
        },
      ),
    );
  }
}
