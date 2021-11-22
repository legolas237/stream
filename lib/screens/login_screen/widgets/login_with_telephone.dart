import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stream/config/config.dart';
import 'package:stream/screens/auth_screen/widgets/telephone_input.dart';
import 'package:stream/screens/login_screen/blocs/send_otp_code/send_otp_code_bloc.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/button/button.dart';
import 'package:stream/widgets/divider/divider.dart';
import 'package:stream/screens/auth_screen/widgets/otp_input.dart';


// ignore: must_be_immutable
class LoginWithTelephoneWidget extends StatelessWidget {
  LoginWithTelephoneWidget({
    Key? key,
  }) : super(key: key);

  late Palette palette;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    return BlocBuilder<SendOtpCodeBloc, SendOtpCodeState>(
      builder: (context, state) {
        if(state.status == SendingStatus.success) {
          return VerifyOtpCodeWidget();
        }

        return Center(
          child: SingleChildScrollView(
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
                    AppLocalizations.of(context)!.enterTelephone,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.subtitle1!.merge(
                      const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                TelephoneInputWidget(
                  country: Constants.defaultCountry,
                ),
                DividerWidget(),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.only(
                    left: Constants.horizontalPadding,
                    right: Constants.horizontalPadding,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.loginTelephoneNotice,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.caption!.merge(
                      const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Constants.horizontalPadding,
                  ),
                  child: ButtonWidget(
                    onPressed: () {
                      BlocProvider.of<SendOtpCodeBloc>(context).add(
                        const SendOtpCode(telephone: ''),
                      );
                    },
                    enabled: true,
                    child: ButtonWidget.buttonTextChild(
                      context: context,
                      enabled: true,
                      text: AppLocalizations.of(context)!.sendCode,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Inner widgets

// ignore: must_be_immutable
class VerifyOtpCodeWidget extends StatefulWidget {
  VerifyOtpCodeWidget({
    Key? key,
  }) : super(key: key);

  late Palette palette;

  @override
  State<StatefulWidget> createState() => _VerifyOtpCodeWidgetState();
}

class _VerifyOtpCodeWidgetState extends State<VerifyOtpCodeWidget> {
  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.appTheme.palette;

    return Center(
      child: SingleChildScrollView(
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
                  '+237 6 78 36 06 96',
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
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.horizontalPadding,
              ),
              child: Wrap(
                children: [
                  ButtonWidget(
                    onPressed: () {},
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
                          BlocProvider.of<SendOtpCodeBloc>(context).add(
                            const SendOtpCode(telephone: ''),
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
            ),
          ],
        ),
      ),
    );
  }
}