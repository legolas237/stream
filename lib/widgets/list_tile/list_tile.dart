import 'package:flutter/material.dart';

import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class ListTileWidget extends StatelessWidget {
  ListTileWidget({
    Key? key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.contentPadding,
  }) : super(key: key);

  late Palette palette;

  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final EdgeInsetsGeometry? contentPadding;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    return Theme(
      data: ThemeData(
        splashColor: palette.splashLightColor(1.0),
      ),
      child: ListTile(
        dense: true,
        onTap: () {
          if(onTap != null) onTap!();
        },
        title: title,
        subtitle: subtitle,
        contentPadding: contentPadding,
        trailing: trailing,
        leading: leading
      ),
    );
  }

  static Widget buttonTitle({
    required Palette palette,
    required BuildContext context,
    required String text,
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
  }) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      textAlign: textAlign,
      style: textStyle ?? Theme.of(context).textTheme.subtitle2!.merge(
        TextStyle(
          color: palette.textColor(1.0),
          fontSize: 13.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static Widget buttonSubTitle({
    required Palette palette,
    required BuildContext context,
    required String text,
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
  }) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      textAlign: textAlign,
      style: textStyle ?? Theme.of(context).textTheme.caption!.merge(
        const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  static Widget buttonLading({
    required Palette palette,
    required BuildContext context,
    required IconData icon,
    Color? color,
    double size = 20.0,
  }) {
    var iconColor = color ?? palette.captionColor(0.8);

    return Icon(
      icon,
      size: size,
      color: iconColor,
    );
  }
}
