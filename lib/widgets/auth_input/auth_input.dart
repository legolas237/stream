import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class AuthInputWidget extends StatelessWidget {
  AuthInputWidget({
    Key? key,
    this.hintText,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 16.0,
    ),
    this.obscureText = false,
    this.style,
    this.inputFormatters,
    this.maxLength,
    this.readOnly = false,
  }) : super(key: key);

  late Palette palette;

  final bool readOnly;
  final String? hintText;
  final TextStyle? style;
  final int? maxLength;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final bool obscureText;
  final EdgeInsetsGeometry? contentPadding;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    return TextFormField(
      enableSuggestions: false,
      enableInteractiveSelection: true,
      autocorrect: false,
      autofocus: false,
      keyboardType: keyboardType,
      maxLines: 1,
      cursorWidth: 2.0,
      controller: controller,
      textAlign: TextAlign.left,
      maxLength: maxLength,
      style: style ?? Theme.of(context).textTheme.subtitle1!.merge(
        TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.w600,
          color: readOnly ? palette.captionColor(0.8) : palette.textColor(1.0),
        ),
      ),
      obscureText: obscureText,
      readOnly: readOnly,
      decoration: InputDecoration(
        filled: false,
        isDense: true,
        counterText: "",
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
        disabledBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
        errorBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.caption!.merge(
          TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w500,
            color: palette.captionColor(0.8),
          ),
        ),
        contentPadding: contentPadding,
      ),
      inputFormatters: inputFormatters,
      onChanged: onChanged,
    );
  }
}