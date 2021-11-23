import 'package:flutter/material.dart';

import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class ListTileTitleWidget extends StatelessWidget {
  ListTileTitleWidget({
    Key? key,
    required this.title,
    this.style,
    this.leading,
    this.trailing,
    this.contentPadding,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  late Palette palette;

  final String title;
  final TextStyle? style;
  final TextAlign? textAlign;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    return ListTile(
      dense: true,
      leading: leading,
      trailing: trailing,
      title: Text(
        title.toUpperCase(),
        textAlign: textAlign,
        style: style ?? Theme.of(context).textTheme.caption!.merge(
          const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
