import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stream/screens/auth_screen/auth_screen.dart';

import 'package:stream/screens/auth_screen/widgets/auth_scaffold.dart';
import 'package:stream/screens/auth_screen/widgets/auth_tab.dart';
import 'package:stream/screens/auth_screen/widgets/auth_tab_item.dart';
import 'package:stream/screens/signup_screen/blocs/signup_bloc/signup_bloc.dart';
import 'package:stream/screens/signup_screen/widgets/signup_with_email.dart';
import 'package:stream/screens/signup_screen/widgets/signup_with_telephone.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/app_scaffold/app_scaffold.dart';
import 'package:stream/widgets/button/button.dart';

// ignore: must_be_immutable
class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';

  SignupScreen({Key? key}) : super(key: key);

  late Palette palette;

  @override
  State<StatefulWidget> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late int _currentTab;

  @override
  void initState() {
    super.initState();
    _currentTab = 2;
  }

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.appTheme.palette;

    return AuthScaffoldWidget(
      resizeToAvoidBottomInset: false,
      contentBottom: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
      content: _buildContent(),
      contentAppBar: _buildAppTitle(),
    );
  }

  // Renders

  Widget _buildAppTitle() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          const SizedBox(width: 4.0),
          Expanded(
            child: ScaffoldWidget.buildTitle(
            context,
            widget.palette,
            AppLocalizations.of(context)!.signupWith,
          ),
          ),
          const SizedBox(width: 6.0),
          AuthTabWidget(
            items: [
              AuthTabItemWidget(
                label: AppLocalizations.of(context)!.email,
                isSelected: _currentTab == 1,
                onSelect: () {
                  setState(() {
                    _currentTab = 1;
                  });
                },
              ),
              AuthTabItemWidget(
                label: AppLocalizations.of(context)!.telephone,
                isSelected: _currentTab == 2,
                onSelect: () {
                  setState(() {
                    _currentTab = 2;
                  });
                },
              ),
            ],
          ),
        ],
      )
    );
  }

  Widget _buildContent() {
    if(_currentTab == 1) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<SignUpBloc>(
            create: (context) => SignUpBloc(),
          )
        ],
        child: SignUpWthEmailWidget(),
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(),
        )
      ],
      child: SignUpWthTelephoneWidget(),
    );
  }
}