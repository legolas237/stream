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
    required this.text,
  }) : super(key: key);

  late Palette palette;

  final String text;
  final bool isSelected;
  final Function? onSelected;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    return Container(
      // margin: const EdgeInsets.only(left: 6.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          if(onSelected != null) onSelected!();
        },
        child: Text(
            text,
            style: Theme.of(context).textTheme.subtitle1!.merge(
                TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? palette.textColor(1.0) : palette.captionColor(1.0),
                )
            )
        ),
      ),
    );
  }
}
