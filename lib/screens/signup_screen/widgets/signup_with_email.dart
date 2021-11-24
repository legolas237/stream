import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stream/config/config.dart';
import 'package:stream/widgets/controlled_input/controlled_input.dart';
import 'package:stream/widgets/date_input/date_input.dart';
import 'package:stream/widgets/password_input/password_input.dart';
import 'package:stream/widgets/username_input/username_input.dart';
import 'package:stream/screens/signup_screen/blocs/signup_bloc/signup_bloc.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/button/button.dart';
import 'package:stream/widgets/divider/divider.dart';
import 'package:stream/widgets/email_input/email_input_bloc_provider.dart';
import 'package:stream/widgets/username_input/username_input_bloc_provider.dart';

// ignore: must_be_immutable
class SignUpWthEmailWidget extends StatelessWidget {
  SignUpWthEmailWidget({
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
              EmailInputWidgetBlocProvider(),
              DividerWidget(),
              UsernameInputWidgetBlocProvider(),
              DividerWidget(),
              const SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.only(
                  left: Constants.horizontalPadding,
                  right: MediaQuery.of(context).size.width * 0.1,
                ),
                child: Text(
                  AppLocalizations.of(context)!.defineStrongPassword,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.subtitle1!.merge(
                    const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              PasswordInputWidget(),
              DividerWidget(),
              PasswordInputWidget(
                hintText: AppLocalizations.of(context)!.confirmPassword,
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
                    text: AppLocalizations.of(context)!.continueAction,
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
          ControlledInputWidget(
            keyboardType: TextInputType.text,
            hintText: AppLocalizations.of(context)!.lastName,
            validateCallback: (value) => value.isNotEmpty,
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
            validateCallback: _validate,
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

  // Callback

  bool _validate(DateTime? date){
    return date != null;
  }
}