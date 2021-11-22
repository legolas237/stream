import 'package:flutter/material.dart';

import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class AuthTabItemWidget extends StatelessWidget {
  AuthTabItemWidget({
    Key? key,
    required this.label,
    this.isSelected = false,
    this.onSelect,
  }) : super(key: key);

  late Palette palette;

  final String label;
  final bool isSelected;
  final Function()? onSelect;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    return GestureDetector(
      onTap: onSelect,
      child: Container(
        margin: const EdgeInsets.only(left: 14.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2.0,
              color: isSelected ? palette.secondaryBrandColor(1.0) : Colors.transparent,
            ),
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1!.merge(
                TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? palette.secondaryBrandColor(1.0) : palette.captionColor(1.0)
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}