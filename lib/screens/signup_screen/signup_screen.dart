import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stream/blocs/counter/counter_bloc.dart';
import 'package:stream/config/config.dart';
import 'package:stream/screens/auth_screen/auth_screen.dart';
import 'package:stream/screens/auth_screen/widgets/auth_scaffold.dart';
import 'package:stream/screens/signup_screen/bloc/signup_bloc.dart';
import 'package:stream/screens/signup_screen/widgets/basic_info_code.dart';
import 'package:stream/screens/signup_screen/widgets/verify_otp_code.dart';
import 'package:stream/screens/tabs_screen/tabs_screen.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/app_scaffold/app_scaffold.dart';
import 'package:stream/widgets/button/button.dart';
import 'package:stream/widgets/divider/divider.dart';
import 'package:stream/widgets/spinner/spinner.dart';
import 'package:stream/widgets/telephone_input/telephone_input.dart';
import 'package:stream/widgets/telephone_input/telephone_input_bloc_provider.dart';
import 'package:stream/widgets/text_error/text_error.dart';

// ignore: must_be_immutable
class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';

  SignupScreen({Key? key}) : super(key: key);

  late Palette palette;

  @override
  State<StatefulWidget> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late PhoneNumber? phoneNumber;

  @override
  void initState() {
    super.initState();

    var bloc = BlocProvider.of<SignUpBloc>(context);

    phoneNumber = bloc.state.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.appTheme.palette;

    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if(state.status == SignUpStatus.otpSent) {
          BlocProvider.of<CounterBloc>(context).add(
            const LaunchCounter(increment: false),
          );
        }

        if(state.status == SignUpStatus.recorded) {
          Navigator.of(context).pushNamedAndRemoveUntil(TabsScreen.routeName, (route) => false,);
        }
      },
      builder: (context, state) {
        return AuthScaffoldWidget(
          contentBottom: state.step == 3 ? _buildSetAvatarAction(state) : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                ),
                child: Text(
                  AppLocalizations.of(context)!.clickToSignIn,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption!.merge(
                    const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 34.0,
                      child: ButtonWidget(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            AuthScreen.routeName,
                          );
                        },
                        enabled: true,
                        child: ButtonWidget.buttonTextChild(
                          context: context,
                          enabled: true,
                          text: AppLocalizations.of(context)!.signIn,
                          textStyle: TextStyle(
                            color: widget.palette.secondaryBrandColor(1),
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ButtonStyleWrapper(
                          palette: widget.palette,
                          enabled: true,
                        ).build(context).copyWith(
                          backgroundColor: MaterialStateColor.resolveWith((states) {
                            return widget.palette.secondaryBrandColor(0.1);
                          },
                          ),
                          overlayColor: MaterialStateColor.resolveWith((states) {
                            return widget.palette.secondaryBrandColor(0.2);
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          content: _buildWidgetTree(state),
          contentAppBar: _buildAppTitle(state),
        );
      }
    );
  }

  // Renders

  Widget _buildWidgetTree(SignUpState state) {
    if(state.step == 1) {
      return VerifyOtpCodeWidget(
        telephone: phoneNumber!.phoneNumber,
      );
    }

    if(state.step == 2) {
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
          TelephoneInputWidgetBlocProvider(
            allowValidation: true,
            phoneNumber: phoneNumber,
            readOnly: state.status == SignUpStatus.processing,
            onChanged: (phone) {
              setState(() {
                phoneNumber = phone;
              });
            },
          ),
          DividerWidget(),
          const SizedBox(height: 20.0),
          _buildErrorWrapper(state),
           SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          _buildActions(state),
        ],
      ),
    );
  }

  Widget _buildDotsIndicators(SignUpState state) {
    return DotsIndicator(
      dotsCount: 3,
      position: state.step.toDouble(),
      decorator: DotsDecorator(
        color: widget.palette.captionColor(0.3),
        activeColor: widget.palette.secondaryBrandColor(1.0),
        size: const Size.square(6.0),
        activeSize: const Size(14.0, 6.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
    );
  }

  Widget _buildActions(SignUpState state) {
    var canSendOtp = phoneNumber != null && phoneNumber!.isValid && state.status != SignUpStatus.processing;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.horizontalPadding,
          ),
          child: ButtonWidget(
            onPressed: () {
              if(canSendOtp) {
                BlocProvider.of<SignUpBloc>(context).add(
                  SendOtp(
                      phoneNumber: phoneNumber!
                  ),
                );
              }
            },
            enabled: canSendOtp,
            child: ButtonWidget.buttonTextChild(
              context: context,
              enabled: canSendOtp,
              text: AppLocalizations.of(context)!.sendCode,
            ),
          ),
        ),
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
    );
  }

  Widget _buildAppTitle(SignUpState state) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0,),
            child: ScaffoldWidget.buildTitle(
              context,
              widget.palette,
              AppLocalizations.of(context)!.signup,
            ),
          )
        ),
        _buildDotsIndicators(state),
      ],
    );
  }

  Widget _buildErrorWrapper(SignUpState state) {
    if(state.status == SignUpStatus.error) {
      return Padding(
        padding: const EdgeInsets.only(
          left: Constants.horizontalPadding,
          right: Constants.horizontalPadding,
        ),
        child: TextErrorWidget(
          text: state.messages ?? AppLocalizations.of(context)!.somethingWrong,
        ),
      );
    }

    return Padding(
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
    );
  }

  Widget _buildSetAvatarAction(SignUpState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.horizontalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ButtonWidget(
            onPressed: () {},
            enabled: true,
            child: ButtonWidget.buttonTextChild(
              context: context,
              enabled: true,
              text: AppLocalizations.of(context)!.setPhoto,
            ),
          ),
          const SizedBox(height: 10.0),
          ButtonWidget(
            onPressed: () {},
            enabled: true,
            child: ButtonWidget.buttonTextChild(
              context: context,
              enabled: true,
              text: AppLocalizations.of(context)!.skip,
              textStyle: Theme.of(context).textTheme.subtitle1!.merge(
                const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            style: ButtonStyleWrapper(
              palette: widget.palette,
              enabled: true,
            ).build(context).copyWith(
              backgroundColor: MaterialStateColor.resolveWith((states) {
                  return Colors.transparent;
                },
              ),
              overlayColor: MaterialStateColor.resolveWith((states) {
                return Colors.transparent;
              }),
            ),
          ),
        ],
      ),
    );
  }
}