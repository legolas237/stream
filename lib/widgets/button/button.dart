import 'package:flutter/material.dart';

import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  ButtonWidget({
    Key? key,
    required this.child,
    required this.onPressed,
    this.enabled = true,
    this.style,
  }) : super(key: key);

  late Palette palette;

  final Widget child;
  final bool enabled;
  final ButtonStyle? style;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;
    var buttonStyle = ButtonStyleWrapper(
      palette: palette,
      enabled: enabled,
    );

    return TextButton(
      onPressed: enabled ? () => onPressed() : null,
      style: style ?? buttonStyle.build(context),
      child: child,
    );
  }

  static Widget buttonTextChild({
    required BuildContext context,
    required String text,
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    bool enabled = true,
  }) {
    Palette palette = ThemeProvider.of(context)!.appTheme.palette;

    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      textAlign: textAlign,
      style: textStyle ?? Theme.of(context).textTheme.subtitle2!.merge(
        TextStyle(
          color: enabled
              ? palette.whiteColor(1)
              : palette.disableButtonTextColor(1),
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class ButtonStyleWrapper {
  ButtonStyleWrapper({
    required this.palette,
    this.enabled = true,
  });

  final Palette palette;
  final bool enabled;

  ButtonStyle build(
    BuildContext context, {
    MaterialStateProperty<Color?>? backgroundColor,
    MaterialStateProperty<double?>? elevation,
    MaterialStateProperty<Color?>? overlayColor,
  }) {
    return const ButtonStyle().copyWith(
      overlayColor: MaterialStateColor.resolveWith((states) {
        return palette.secondarySplashColor(1.0);
      }),
      backgroundColor: MaterialStateColor.resolveWith(
        (states) {
          return enabled
              ? palette.secondaryBrandColor(1.0)
              : palette.disableButtonColor(1.0);
        },
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          side: BorderSide(
            color: enabled
                ? Colors.transparent
                : palette.disableButtonBorderColor(0.8),
            width: 1.0,
          ),
        ),
      ),
      elevation: MaterialStateProperty.all(0.0),
    );
  }
}
