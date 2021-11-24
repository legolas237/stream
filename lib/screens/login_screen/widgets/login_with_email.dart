import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stream/config/config.dart';
import 'package:stream/widgets/password_input/password_input.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/button/button.dart';
import 'package:stream/widgets/divider/divider.dart';
import 'package:stream/widgets/email_input/email_input_bloc_provider.dart';

// ignore: must_be_immutable
class LoginWithEmailWidget extends StatelessWidget {
  LoginWithEmailWidget({
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
              AppLocalizations.of(context)!.enterEmailPassword,
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
          PasswordInputWidget(),
          const SizedBox(height: 24.0),
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
                    text: AppLocalizations.of(context)!.connection,
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
                        AppLocalizations.of(context)!.forgotPassword,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.subtitle1!.merge(
                          TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: palette.linkColor(1.0),
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