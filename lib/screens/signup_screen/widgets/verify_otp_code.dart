import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

import 'package:stream/blocs/counter/counter_bloc.dart';
import 'package:stream/config/config.dart';
import 'package:stream/screens/signup_screen/bloc/signup_bloc.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/button/button.dart';
import 'package:stream/widgets/divider/divider.dart';
import 'package:stream/widgets/otp_input/otp_input.dart';
import 'package:stream/widgets/spinner/spinner.dart';
import 'package:stream/widgets/text_error/text_error.dart';

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
  late String otpValue;

  @override
  void initState() {
    super.initState();
    otpValue = '';
  }

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
                OtpInputWidget(
                  readOnly: state.status == SignUpStatus.processing,
                  clearCallback: () {
                    BlocProvider.of<SignUpBloc>(context).add(
                      ResetState(),
                    );
                  },
                  onChanged: (value) {
                    setState(() {
                      otpValue = value;
                    });
                  },
                  validateCallback: (value) {
                    return value.length == Constants.otpLength;
                  },
                ),
                DividerWidget(),
                const SizedBox(height: 20.0),
                _buildErrorWrapper(state),
                _buildCounter(),
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
    var canRequest = otpValue.length == Constants.otpLength && state.status != SignUpStatus.processing;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.horizontalPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ButtonWidget(
            onPressed: () {
              if(canRequest) {
                BlocProvider.of<SignUpBloc>(context).add(
                  VerifyOtp(otp: otpValue),
                );
              }
            },
            enabled: canRequest,
            child: ButtonWidget.buttonTextChild(
              context: context,
              enabled: canRequest,
              text: AppLocalizations.of(context)!.verifyOtp,
            ),
          ),
          const SizedBox(width: 14.0),
          _buildSpinner(state),
        ],
      ),
    );
  }

  Widget _buildCounter() {
    var bloc = BlocProvider.of<SignUpBloc>(context);

    return BlocConsumer<CounterBloc, CounterState>(
      listener: (context, state) {
        var counterBloc = BlocProvider.of<CounterBloc>(context);
        if(counterBloc.state.status == CounterStatus.ended) {
          BlocProvider.of<CounterBloc>(context).add(
            const ResetCounter(start: 15, end: 1),
          );
        }
      },
      builder: (context, state) {
        if(state.status == CounterStatus.counting) {
          return Padding(
            padding: EdgeInsets.only(
              left: Constants.horizontalPadding,
              right: MediaQuery.of(context).size.width * 0.1,
            ),
            child: Text(
              AppLocalizations.of(context)!.resendCodeIn(state.start),
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

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.horizontalPadding,
          ),
          child: GestureDetector(
            onTap: () {
              if(bloc.state.status != SignUpStatus.processing) {
                bloc.add(
                  SendOtp(phoneNumber: bloc.state.phoneNumber!,),
                );
              }
            },
            child: Text(
              AppLocalizations.of(context)!.resendCode,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.subtitle1!.merge(
                TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                  color: bloc.state.status != SignUpStatus.processing ? widget.palette.secondaryBrandColor(1.0) : widget.palette.captionColor(1.0),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSpinner(SignUpState state) {
    if(state.status == SignUpStatus.processing) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: SizedBox(
          height: 18.0,
          width: 18.0,
          child: SpinnerWidget(
            strokeWidth: 1.8,
            colors: AlwaysStoppedAnimation<Color>(
              widget.palette.secondaryBrandColor(1.0),
            ),
          ),
        ),
      );
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle1!.merge(
              TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: widget.palette.linkColor(1.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWrapper(SignUpState state) {
    if(state.status == SignUpStatus.error) {
      return Padding(
        padding: const EdgeInsets.only(
          left: Constants.horizontalPadding,
          right: Constants.horizontalPadding,
          bottom: Constants.verticalPadding,
        ),
        child: TextErrorWidget(
          text: state.messages ?? AppLocalizations.of(context)!.somethingWrong,
        ),
      );
    }

    return const SizedBox();
  }
}