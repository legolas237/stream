import 'package:flutter/material.dart';

import 'package:stream/screens/auth_screen/widgets/auth_input.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/spinner/spinner.dart';

// ignore: must_be_immutable
class ControlledInputWidget extends StatelessWidget {
  ControlledInputWidget({
    Key? key,
    this.onChanged,
    this.controller,
    this.hintText,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  late Palette palette;

  final String? hintText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    return Row(
      children: [
        Expanded(
          child: AuthInputWidget(
            keyboardType: keyboardType,
            hintText: hintText,
            contentPadding: const EdgeInsets.only(
              left: 20.0,
              top: 18.0,
              bottom: 18.0,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 20.0,
          ),
          child: _buildSuffix(),
        ),
      ],
    );
  }

  // Render

  Widget _buildSuffix() {
    return Icon(
      Icons.check_circle,
      size: 15.0,
      color: palette.secondaryBrandColor(1.0),
    );

    return SizedBox(
        height: 15.0,
        width: 15.0,
        child: SpinnerWidget(
          colors: AlwaysStoppedAnimation<Color>(palette.secondaryBrandColor(1.0),),
          strokeWidth: 1.6,
        )
    );
  }
}