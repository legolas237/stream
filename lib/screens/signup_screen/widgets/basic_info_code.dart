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
import 'package:stream/widgets/text_error/text_error.dart';

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
  bool passwordValidity = false;
  TextEditingController passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.appTheme.palette;

    var bloc = BlocProvider.of<SignUpBloc>(context);

    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
                ControlledInputWidget(
                  readOnly: state.status == SignUpStatus.processing,
                  keyboardType: TextInputType.text,
                  hintText: AppLocalizations.of(context)!.fullName,
                  validateCallback: (value) {
                    return value.length >= 3;
                  },
                  onChanged: (value) {
                    bloc.add(InputChange(attribute: 'name', value: value));
                  },
                  helperText: () {
                    if(state.status == SignUpStatus.error && state.messages is Map && (state.messages as Map).keys.contains('name')) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: Constants.horizontalPadding,
                          right: Constants.horizontalPadding,
                          bottom: Constants.verticalPadding,
                        ),
                        child: TextErrorWidget(
                          text: (state.messages['name'] as List).first.toString(),
                        )
                      );
                    }

                    return const SizedBox();
                  },
                ),
                DividerWidget(),
                DateInputWidget(
                  readOnly: state.status == SignUpStatus.processing,
                  maxYear: DateTime.now().year - 17,
                  minYear: 1950,
                  hintText: AppLocalizations.of(context)!.yourBirthday,
                  validateCallback: (value) {
                    return value != null;
                  },
                  onChanged: (value) {
                    if(value != null) {
                      bloc.add(
                        InputChange(
                          attribute: 'data_of_birth',
                          value: Hooks.formatDate(value, 'yyyy-MM-dd'),
                        ),
                      );
                    }

                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  helperText: () {
                    if(state.status == SignUpStatus.error && state.messages is Map && (state.messages as Map).keys.contains('data_of_birth')) {
                      return Padding(
                          padding: const EdgeInsets.only(
                            left: Constants.horizontalPadding,
                            right: Constants.horizontalPadding,
                            bottom: Constants.verticalPadding,
                          ),
                          child: TextErrorWidget(
                            text: (state.messages['data_of_birth'] as List).first.toString(),
                          )
                      );
                    }

                    return const SizedBox();
                  },
                ),
                DividerWidget(),
                PasswordInputWidget(
                  readOnly: state.status == SignUpStatus.processing,
                  hintText: AppLocalizations.of(context)!.yourPassword,
                  onChanged: (value) {
                    bloc.add(InputChange(attribute: 'password', value: value));
                    setState(() {
                      passwordValidity = value == passwordConfirmController.text;
                    });
                  },
                  helperText: () {
                    if(state.status == SignUpStatus.error && state.messages is Map && (state.messages as Map).keys.contains('password')) {
                      return Padding(
                          padding: const EdgeInsets.only(
                            left: Constants.horizontalPadding,
                            right: Constants.horizontalPadding,
                            bottom: Constants.verticalPadding,
                          ),
                          child: TextErrorWidget(
                            text: (state.messages['password'] as List).first.toString(),
                          )
                      );
                    }

                    return Padding(
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
                    );
                  },
                ),
                const SizedBox(height: 20.0),
                DividerWidget(),
                PasswordInputWidget(
                  readOnly: state.status == SignUpStatus.processing,
                  controller: passwordConfirmController,
                  hintText: AppLocalizations.of(context)!.confirmPassword,
                  validate: (value) {
                    return passwordValidity;
                  },
                  onChanged: (value) {
                    setState(() {
                      passwordValidity = state.registrationData.keys.contains('password') && state.registrationData['password'] == value;
                    });
                  },
                ),
                DividerWidget(),
                _buildActions(state),
              ],
            ),
          )
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildErrorWrapper(state),
          const SizedBox(height: 20.0),
          Row(
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
          )
        ],
      ),
    );
  }

  Widget _buildErrorWrapper(SignUpState state) {
    if(state.status == SignUpStatus.error && (state.messages== null || state.messages is String)) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Constants.verticalPadding,
        ),
        child: TextErrorWidget(
          text: state.messages ?? AppLocalizations.of(context)!.somethingWrong,
        ),
      );
    }

    return const SizedBox();
  }
}
