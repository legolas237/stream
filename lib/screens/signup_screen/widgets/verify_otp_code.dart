import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

import 'package:stream/config/config.dart';
import 'package:stream/screens/signup_screen/bloc/signup_bloc.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/button/button.dart';
import 'package:stream/widgets/divider/divider.dart';
import 'package:stream/widgets/otp_input/otp_input.dart';

// ignore: must_be_immutable
class VerifyOtpCodeWidget extends StatefulWidget {
  VerifyOtpCodeWidget({
    Key? key,
    required this.telephone,
  }) : super(key: key);

  late Palette palette;

  final String telephone;

  @override
  State<StatefulWidget> createState() => _VerifyOtpCodeWidgetState();
}

class _VerifyOtpCodeWidgetState extends State<VerifyOtpCodeWidget> {
  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.appTheme.palette;

    return BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              vertical: Constants.verticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: Constants.horizontalPadding,
                    right: MediaQuery.of(context).size.width * 0.1,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.enterOtpCode(
                      Constants.otpLength,
                    ),
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.subtitle1!.merge(
                      const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4.0),
                Padding(
                  padding: EdgeInsets.only(
                    left: Constants.horizontalPadding,
                    right: MediaQuery.of(context).size.width * 0.1,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.codeSendTo(
                        FlutterLibphonenumber().formatNumberSync(widget.telephone,)
                    ),
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.caption!.merge(
                      const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                OtpInputWidget(),
                DividerWidget(),
                const SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.only(
                    left: Constants.horizontalPadding,
                    right: MediaQuery.of(context).size.width * 0.1,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.resendCodeIn(
                      '90',
                    ),
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.caption!.merge(
                      const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                _buildActions(state),
              ],
            ),
          );
        }
    );
  }

  // Renders

  Widget _buildActions(SignUpState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.horizontalPadding,
      ),
      child: Wrap(
        children: [
          ButtonWidget(
            onPressed: () {
            },
            enabled: true,
            child: ButtonWidget.buttonTextChild(
              context: context,
              enabled: true,
              text: AppLocalizations.of(context)!.verifyOtp,
            ),
          ),
          const SizedBox(width: 14.0),
          Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
              ),
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<SignUpBloc>(context).add(
                    const ChangeStep(step: 0),
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.changePhoneNumber,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.subtitle1!.merge(
                    TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: widget.palette.linkColor(1.0),
                    ),
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}