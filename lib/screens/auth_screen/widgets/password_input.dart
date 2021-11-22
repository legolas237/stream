import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stream/screens/auth_screen/widgets/auth_input.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/app_bar_action/app_bar_action.dart';

// ignore: must_be_immutable
class PasswordInputWidget extends StatefulWidget {
  PasswordInputWidget({
    Key? key,
    this.onChanged,
    this.controller,
    this.hintText,
  }) : super(key: key);

  late Palette palette;

  final String? hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  @override
  State<StatefulWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.appTheme.palette;

    return Row(
      children: [
        Expanded(
          child: AuthInputWidget(
            keyboardType: TextInputType.text,
            obscureText: isVisible,
            hintText: widget.hintText ?? AppLocalizations.of(context)!.yourPassword,
            contentPadding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 16.0,
              bottom: 16.0,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 4.0,
          ),
          child: _buildSuffix(),
        ),
      ],
    );
  }

  // Render

   Widget _buildSuffix() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.check_circle,
          size: 15.0,
          color: widget.palette.secondaryBrandColor(1.0),
        ),
        const SizedBox(width: 10.0),
        AppBarActionWidget(
          onPressed: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
          splashColor: widget.palette.splashLightColor(1.0),
          highLightColor: widget.palette.highLightLightColor(1.0),
          icon: Icon(
            isVisible ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
            size: 20.0,
            color: isVisible ? widget.palette.secondaryBrandColor(1.0) : widget.palette.captionColor(1.0),
          ),
        ),
      ],
    );
   }
}