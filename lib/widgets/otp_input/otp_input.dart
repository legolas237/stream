import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stream/config/config.dart';
import 'package:stream/widgets/auth_input/auth_input.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class OtpInputWidget extends StatefulWidget {
  OtpInputWidget({
    Key? key,
    this.onChanged,
    this.controller,
    this.validateCallback,
  }) : super(key: key);

  late Palette palette;

  final TextEditingController? controller;
  final bool Function(String)? validateCallback;
  final Function(String)? onChanged;

  @override
  State<StatefulWidget> createState() => _OtpInputWidgetState();
}

class _OtpInputWidgetState extends State<OtpInputWidget> {
  late bool isValid;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = widget.controller ?? TextEditingController();
    isValid = widget.validateCallback != null ? widget.validateCallback!(controller.text,) : false;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.appTheme.palette;

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
            onChanged: (value) {
              if(widget.onChanged != null) widget.onChanged!(value);

              if(widget.validateCallback != null) {
                setState(() {
                  isValid = widget.validateCallback!(value);
                });
              }
            },
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
    if(widget.validateCallback != null && isValid) {
      return Icon(
        Icons.check_circle,
        size: 15.0,
        color: widget.palette.secondaryBrandColor(1.0),
      );
    }

    if(widget.validateCallback != null) {
      return Icon(
        Icons.check_circle,
        size: 15.0,
        color: widget.palette.captionColor(0.2),
      );
    }

    return const SizedBox();
   }
}