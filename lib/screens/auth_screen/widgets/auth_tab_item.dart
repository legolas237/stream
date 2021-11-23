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
        margin: const EdgeInsets.only(left: 16.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        // decoration: BoxDecoration(
        //   border: Border(
        //     bottom: BorderSide(
        //       width: 2.0,
        //       color: isSelected ? palette.whiteColor(1.0) : Colors.transparent,
        //     ),
        //   ),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8.0),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1!.merge(
                TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? palette.whiteColor(1.0) : palette.whiteColor(0.5)
                ),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 4.0,
              width: 4.0,
              decoration: BoxDecoration(
                color: isSelected ? palette.whiteColor(1.0) : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
          ],
        )
      ),
    );
  }
}