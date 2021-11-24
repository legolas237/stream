import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stream/config/config.dart';
import 'package:stream/widgets/controlled_input/controlled_input.dart';
import 'package:stream/widgets/date_input/date_input.dart';
import 'package:stream/widgets/otp_input/otp_input.dart';
import 'package:stream/widgets/telephone_input/telephone_input.dart';
import 'package:stream/widgets/username_input/username_input.dart';
import 'package:stream/screens/signup_screen/blocs/signup_bloc/signup_bloc.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/button/button.dart';
import 'package:stream/widgets/divider/divider.dart';
import 'package:stream/widgets/username_input/username_input_bloc_provider.dart';

// ignore: must_be_immutable
class SignUpWthTelephoneWidget extends StatelessWidget {
  SignUpWthTelephoneWidget({
    Key? key,
  }) : super(key: key);

  late Palette palette;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        if (state.status == SignUpStatus.success) {
          return BasicInformationWidget();
        }

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                    BlocProvider.of<SignUpBloc>(context).add(
                      SignUp(),
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
        );
      }
    );
  }
}

// Inner widgets

// ignore: must_be_immutable
class BasicInformationWidget extends StatelessWidget {
  BasicInformationWidget({
    Key? key,
  }) : super(key: key);

  late Palette palette;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

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
              AppLocalizations.of(context)!.createAccount,
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
          UsernameInputWidgetBlocProvider(),
          DividerWidget(),
          ControlledInputWidget(
            keyboardType: TextInputType.text,
            hintText: AppLocalizations.of(context)!.lastName,
          ),
          DividerWidget(),
          ControlledInputWidget(
            keyboardType: TextInputType.text,
            hintText: AppLocalizations.of(context)!.firstName,
          ),
          DividerWidget(),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.horizontalPadding,
            ),
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                style: Theme.of(context).textTheme.subtitle1!.merge(
                  const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: AppLocalizations.of(context)!.legalReasons,
                  ),
                  TextSpan(
                    text: ' ${AppLocalizations.of(context)!.readMore}',
                    style: TextStyle(
                      color: palette.linkColor(1.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          DateInputWidget(
            hintText: AppLocalizations.of(context)!.yourBirthday,
          ),
          DividerWidget(),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.horizontalPadding,
            ),
            child: ButtonWidget(
              onPressed: () {
                BlocProvider.of<SignUpBloc>(context).add(
                  SignUp(),
                );
              },
              enabled: true,
              child: ButtonWidget.buttonTextChild(
                context: context,
                enabled: true,
                text: AppLocalizations.of(context)!.registration,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
                    onPressed: () {
                      BlocProvider.of<SignUpBloc>(context).add(
                        SignUp(),
                      );
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
                        onTap: () {},
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
      );
  }
}