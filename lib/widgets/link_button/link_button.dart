import 'package:flutter/material.dart';

import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class LinkButtonWidget extends StatelessWidget{
  LinkButtonWidget({
    Key? key,
    required this.child,
    this.onTap,
    this.enabled = true,
    this.padding = const EdgeInsets.symmetric(
      vertical: 6.0,
    ),
  }) : super(key: key);

  late Palette palette;

  final Widget child;
  final bool enabled;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    return GestureDetector(
      onTap: () {
        if(onTap != null && enabled) onTap!();
      },
      child: Container(
        padding: padding,
        child: child,
      ),
    );
  }

  static Widget flatButtonTitle(BuildContext context, String text, {TextStyle? textStyle}){
    return Text(
      text,
      style: textStyle ?? Theme.of(context).textTheme.subtitle2,
    );
  }
}