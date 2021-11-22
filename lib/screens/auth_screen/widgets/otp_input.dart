import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stream/config/config.dart';

import 'package:stream/screens/auth_screen/widgets/auth_input.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class OtpInputWidget extends StatelessWidget {
  OtpInputWidget({
    Key? key,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  late Palette palette;

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
            hintText: AppLocalizations.of(context)!.code,
            maxLength: Constants.otpLength,
            keyboardType: TextInputType.number,
            style: Theme.of(context).textTheme.subtitle1!.merge(
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            contentPadding: const EdgeInsets.only(
              left: 20.0,
              top: 18.0,
              bottom: 14.0,
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
   }
}