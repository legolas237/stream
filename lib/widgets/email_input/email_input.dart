import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stream/config/config.dart';
import 'package:string_validator/string_validator.dart';

import 'package:stream/widgets/auth_input/auth_input.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/email_input/bloc/email_verify_bloc.dart';
import 'package:stream/widgets/spinner/spinner.dart';

// ignore: must_be_immutable
class EmailInputWidget extends StatefulWidget {
  EmailInputWidget({
    Key? key,
    this.onChanged,
    this.controller,
    this.checkEmail = true,
  }) : super(key: key);

  late Palette palette;

  final bool checkEmail;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  @override
  State<StatefulWidget> createState() => _EmailInputWidgetState();
}

class _EmailInputWidgetState extends State<EmailInputWidget> {
  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.appTheme.palette;

    return BlocConsumer<EmailVerifyBloc, EmailVerifyState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: AuthInputWidget(
                    keyboardType: TextInputType.emailAddress,
                    controller: widget.controller,
                    hintText: AppLocalizations.of(context)!.fullEmail,
                    contentPadding: const EdgeInsets.only(
                      left: 20.0,
                      top: 18.0,
                      bottom: 18.0,
                    ),
                    onChanged: (value) {
                      if(widget.onChanged != null) widget.onChanged!(value);

                      if(widget.checkEmail && isEmail(value)) {
                        BlocProvider.of<EmailVerifyBloc>(context).add(
                          Verify(email: value),
                        );
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 20.0,
                  ),
                  child: _buildSuffix(state),
                ),
              ],
            ),
            if(state.status == CheckStatus.existing) Padding(
              padding: const EdgeInsets.only(
                left: Constants.horizontalPadding,
                right: Constants.horizontalPadding,
                bottom: 20.0,
              ),
              child:   Text(
                AppLocalizations.of(context)!.existingEmailError,
                style: Theme.of(context).textTheme.subtitle1!.merge(
                  TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).errorColor,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Render

   Widget _buildSuffix(EmailVerifyState state,) {
    if(state.status == CheckStatus.verifying) {
      return SizedBox(
          height: 14.0,
          width: 14.0,
          child: SpinnerWidget(
            colors: AlwaysStoppedAnimation<Color>(widget.palette.secondaryBrandColor(1.0),),
            strokeWidth: 1.6,
          )
      );
    }

    if(widget.checkEmail && state.status == CheckStatus.success) {
      return Icon(
        Icons.check_circle,
        size: 15.0,
        color: widget.palette.secondaryBrandColor(1.0),
      );
    }

    if(widget.checkEmail && state.status == CheckStatus.existing) {
      return Icon(
        Icons.check_circle,
        size: 15.0,
        color: Theme.of(context).errorColor,
      );
    }

    if (widget.checkEmail) {
      return Icon(
        Icons.check_circle,
        size: 15.0,
        color: widget.palette.captionColor(0.2),
      );
    }

    return const SizedBox();
   }
}