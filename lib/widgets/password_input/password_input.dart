import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stream/config/config.dart';
import 'package:stream/config/hooks.dart';
import 'package:stream/widgets/auth_input/auth_input.dart';
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
    this.verifyStrong = true,
  }) : super(key: key);

  late Palette palette;

  final String? hintText;
  final bool verifyStrong;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  @override
  State<StatefulWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  late bool isVisible = false;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = widget.controller ?? TextEditingController();
    isVisible = false;
  }

  String password = '';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.appTheme.palette;

    var passwordStatus = _computeStatus(password);

    return  Row(
      children: [
        Expanded(
          child: AuthInputWidget(
            keyboardType: TextInputType.text,
            obscureText: !isVisible,
            controller: controller,
            hintText: widget.hintText ?? AppLocalizations.of(context)!.yourPassword,
            contentPadding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 16.0,
              bottom: 16.0,
            ),
            onChanged: (value) {
              if(widget.onChanged != null) {
                widget.onChanged!(value);
              }

              if(widget.verifyStrong) {
                setState(() {
                  password = value;
                });
              }
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 4.0,
          ),
          child: _buildSuffix(passwordStatus),
        ),
      ],
    );
  }

  // Render

   Widget _buildSuffix(bool passwordStatus,) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if(widget.verifyStrong) Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Icon(
            Icons.check_circle,
            size: 15.0,
            color: _colorStatus(passwordStatus),
          ),
        ),
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

   // Callback

  bool _computeStatus(String value) {
    bool hasMiLength  = false;
    bool hasUppercase  = false;
    bool hasDigits = false;
    bool hasLowercase = false;
    bool hasSpecialCharacters = false;
    var character = '';
    var i = 0;

    if (value.isNotEmpty) {
      if (value.length >= Constants.passwordMinLength) {
        hasMiLength = true;
      }

      // Check if valid special characters are present
      hasSpecialCharacters = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      while (i < value.length){
        character = value.substring(i,i+1);

        if (Hooks.isDigit(character , 0)){
          hasDigits = true;
        }else{
          if (character == character.toUpperCase()) {
            hasUppercase = true;
          }
          if (character == character.toLowerCase()){
            hasLowercase = true;
          }
        }
        i++;
      }
    }

    return hasMiLength && hasDigits && hasUppercase && hasLowercase && hasSpecialCharacters;
  }

  Color _colorStatus(bool status) {
    if(! status) return widget.palette.captionColor(0.2);

    return widget.palette.secondaryBrandColor(1.0);
  }
}