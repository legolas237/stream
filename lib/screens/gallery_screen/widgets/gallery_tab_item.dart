import 'package:flutter/material.dart';

import 'package:stream/config/config.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class GalleryTabItemWidget extends StatelessWidget {
  GalleryTabItemWidget({
    Key? key,
    this.onSelected,
    this.isSelected = false,
    required this.icon,
  }) : super(key: key);

  late Palette palette;

  final IconData icon;
  final bool isSelected;
  final Function? onSelected;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if(onSelected != null) onSelected!();
        },
        splashColor: palette.splashLightColor(1.0),
        highlightColor: palette.highLightLightColor(1.0),
        hoverColor: palette.highLightLightColor(1.0),
        child: Container(
          margin: const EdgeInsets.only(left: 10.0),
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 2.0,
                color: isSelected ? palette.secondaryBrandColor(1.0) : Colors.transparent,
              ),
            ),
          ),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18.0,
                color: isSelected ? palette.secondaryBrandColor(1.0) : palette.captionColor(0.6),
              )
            ],
          ),
        ),
      ),
    );
  }
}
