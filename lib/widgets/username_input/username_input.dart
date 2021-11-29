import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stream/config/config.dart';

import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/app_bar_action/app_bar_action.dart';
import 'package:stream/widgets/auth_input/auth_input.dart';
import 'package:stream/widgets/spinner/spinner.dart';
import 'package:stream/widgets/text_error/text_error.dart';
import 'package:stream/widgets/username_input/bloc/username_verify_bloc.dart';

// ignore: must_be_immutable
class UserNameInputWidget extends StatefulWidget {
  UserNameInputWidget({
    Key? key,
    this.onChanged,
    this.controller,
    this.checkUsername = true,
  }) : super(key: key);

  late Palette palette;

  final bool checkUsername;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  @override
  State<StatefulWidget> createState() => _UserNameInputWidgetState();
}

class _UserNameInputWidgetState extends State<UserNameInputWidget> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = widget.controller ?? TextEditingController();
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

    return BlocConsumer<UsernameVerifyBloc, UsernameVerifyState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: AuthInputWidget(
                    keyboardType: TextInputType.text,
                    controller: controller,
                    hintText: AppLocalizations.of(context)!.userName,
                    contentPadding: const EdgeInsets.only(
                      left: 20.0,
                      top: 18.0,
                      bottom: 18.0,
                    ),
                    onChanged: (value) {
                      if(widget.checkUsername && value.length >= 3) {
                        BlocProvider.of<UsernameVerifyBloc>(context).add(
                          Verify(username: value),
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
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: widget.checkUsername ? 10.0 : 0.0,
                        ),
                        child: AppBarActionWidget(
                          onPressed: () {
                            controller.clear();
                            if(widget.onChanged != null) widget.onChanged!('');
                          },
                          splashColor: widget.palette.splashLightColor(1.0),
                          highLightColor: widget.palette.highLightLightColor(1.0),
                          icon: Icon(
                            Icons.close,
                            size: 16.0,
                            color: widget.palette.captionColor(0.8),
                          ),
                        ),
                      ),
                      _buildSuffix(state),
                    ],
                  ),
                ),
              ],
            ),
            _buildBottomMessage(state),
          ],
        );
      }
    );
  }

  // Render

  Widget _buildBottomMessage(UsernameVerifyState state,) {
    if (state.status == CheckStatus.existing) {
      return Padding(
        padding: const EdgeInsets.only(
          left: Constants.horizontalPadding,
          right: Constants.horizontalPadding,
          bottom: 20.0,
        ),
        child: TextErrorWidget(
          text: AppLocalizations.of(context)!.existingEmailError,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(
        left: Constants.horizontalPadding,
        right: Constants.horizontalPadding,
        bottom: Constants.verticalPadding,
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
              text: AppLocalizations.of(context)!.userNameNotice,
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
    );
  }

  Widget _buildSuffix(UsernameVerifyState state,) {
     if (state.status == CheckStatus.verifying) {
       return SizedBox(
           height: 14.0,
           width: 14.0,
           child: SpinnerWidget(
             colors: AlwaysStoppedAnimation<Color>(widget.palette.secondaryBrandColor(1.0),),
             strokeWidth: 1.6,
           )
       );
     }

     if (widget.checkUsername && state.status == CheckStatus.success) {
       return Icon(
         Icons.check_circle,
         size: 15.0,
         color: widget.palette.secondaryBrandColor(1.0),
       );
     }

     if (widget.checkUsername && state.status == CheckStatus.existing) {
       return Icon(
         Icons.check_circle,
         size: 15.0,
         color: Theme.of(context).errorColor,
       );
     }

     if (widget.checkUsername) {
       return Icon(
         Icons.check_circle,
         size: 15.0,
         color: widget.palette.captionColor(0.2),
       );
     }

     return const SizedBox();
   }
}