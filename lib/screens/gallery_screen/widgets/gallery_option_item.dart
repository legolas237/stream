import 'package:flutter/material.dart';

import 'package:stream/config/config.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class GalleryOptionItemWidget extends StatelessWidget {
  GalleryOptionItemWidget({
    Key? key,
    required this.content,
    this.onSelected,
    required this.icon,
  }) : super(key: key);

  late Palette palette;

  final String content;
  final IconData icon;
  final Function? onSelected;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if(onSelected != null){
            onSelected!();
          }
        },
        splashColor: palette.splashLightColor(1.0),
        highlightColor: palette.highLightLightColor(1.0),
        hoverColor: palette.highLightLightColor(1.0),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.horizontalPadding,
            vertical: 14.0,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 17.0,
                color: palette.textColor(0.8),
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: Text(
                  content,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle2!.merge(
                    const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
