import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stream/config/config.dart';
import 'package:stream/config/hooks.dart';
import 'package:stream/screens/signup_screen/bloc/signup_bloc.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/button/button.dart';
import 'package:stream/widgets/controlled_input/controlled_input.dart';
import 'package:stream/widgets/date_input/date_input.dart';
import 'package:stream/widgets/divider/divider.dart';
import 'package:stream/widgets/password_input/password_input.dart';
import 'package:stream/widgets/spinner/spinner.dart';
import 'package:stream/widgets/username_input/username_input_bloc_provider.dart';

// ignore: must_be_immutable
class BasicInformationWidget extends StatefulWidget {
  BasicInformationWidget({
    Key? key,
  }) : super(key: key);

  late Palette palette;

  @override
  State<StatefulWidget> createState() => _BasicInformationWidgetState();
}

class _BasicInformationWidgetState extends State<BasicInformationWidget> {
  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.appTheme.palette;

    var bloc = BlocProvider.of<SignUpBloc>(context);

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
              const SizedBox(height: 4.0),
              Padding(
                padding: EdgeInsets.only(
                  left: Constants.horizontalPadding,
                  right: MediaQuery.of(context).size.width * 0.1,
                ),
                child: Text(
                  AppLocalizations.of(context)!.signupNotice,
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
              UsernameInputWidgetBlocProvider(
                onChanged: (value) {
                  bloc.add(InputChange(attribute: 'username', value: value.toString()));
                },
              ),
              DividerWidget(),
              ControlledInputWidget(
                keyboardType: TextInputType.text,
                hintText: AppLocalizations.of(context)!.lastName,
                validateCallback: (value) {
                  return value.length >= 2;
                },
                onChanged: (value) {
                  bloc.add(InputChange(attribute: 'last_name', value: value));
                },
              ),
              DividerWidget(),
              ControlledInputWidget(
                keyboardType: TextInputType.text,
                hintText: AppLocalizations.of(context)!.firstName,
                validateCallback: (value) {
                  return value.length >= 2;
                },
                onChanged: (value) {
                  bloc.add(InputChange(attribute: 'first_name', value: value));
                },
              ),
              DividerWidget(),
              DateInputWidget(
                maxYear: DateTime.now().year,
                minYear: 1950,
                hintText: AppLocalizations.of(context)!.yourBirthday,
                validateCallback: (value) {
                  return value != null;
                },
                onChanged: (value) {
                  if(value != null) {
                    bloc.add(
                      InputChange(
                        attribute: 'date_of_birth',
                        value: Hooks.formatDate(value, 'yyyy-MM-dd'),
                      ),
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Constants.horizontalPadding,
                ),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.subtitle1!.merge(
                      const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: AppLocalizations.of(context)!.legalReasons,
                      ),
                      TextSpan(
                        text: ' ${AppLocalizations.of(context)!.readMore}',
                        style: TextStyle(
                          color: widget.palette.linkColor(1.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              DividerWidget(),
              PasswordInputWidget(
                hintText: AppLocalizations.of(context)!.yourPassword,
                onChanged: (value) {
                  bloc.add(InputChange(attribute: 'password', value: value));
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Constants.horizontalPadding,
                ),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.subtitle1!.merge(
                      const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: AppLocalizations.of(context)!.defineStrongPassword,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              DividerWidget(),
              PasswordInputWidget(
                hintText: AppLocalizations.of(context)!.confirmPassword,
              ),
              DividerWidget(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              _buildActions(state),
            ],
          ),
        );
      }
    );
  }

  // Render

  Widget _buildActions(SignUpState state) {
    var canSend = state.status == SignUpStatus.readyToRegister || state.status == SignUpStatus.error;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.horizontalPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ButtonWidget(
            onPressed: () {
              if(canSend) {
                BlocProvider.of<SignUpBloc>(context).add(
                  MakeRegistration(),
                );
              }
            },
            enabled: canSend,
            child: ButtonWidget.buttonTextChild(
              context: context,
              enabled: canSend,
              text: AppLocalizations.of(context)!.registration,
            ),
          ),
          const SizedBox(width: 28.0),
          if(state.status == SignUpStatus.processing) SizedBox(
            height: 18.0,
            width: 18.0,
            child: SpinnerWidget(
              strokeWidth: 1.8,
              colors: AlwaysStoppedAnimation<Color>(
                widget.palette.secondaryBrandColor(1.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
