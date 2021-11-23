import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/size/gf_size.dart';

import 'package:stream/screens/auth_screen/widgets/auth_scaffold.dart';
import 'package:stream/screens/auth_screen/widgets/auth_tab.dart';
import 'package:stream/screens/auth_screen/widgets/auth_tab_item.dart';
import 'package:stream/screens/login_screen/blocs/send_otp_code/send_otp_code_bloc.dart';
import 'package:stream/screens/login_screen/widgets/login_with_email.dart';
import 'package:stream/screens/login_screen/widgets/login_with_telephone.dart';
import 'package:stream/screens/signup_screen/signup_screen.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/app_scaffold/app_scaffold.dart';
import 'package:stream/widgets/button/button.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  late Palette palette;

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
      contentBottom: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
            ),
            child: Text(
              AppLocalizations.of(context)!.clickToSignUp,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 34.0,
                  child: ButtonWidget(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        SignupScreen.routeName,
                      );
                    },
                    enabled: true,
                    child: ButtonWidget.buttonTextChild(
                      context: context,
                      enabled: true,
                      text: AppLocalizations.of(context)!.signup,
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
                const SizedBox(width: 10.0),
                Text(
                  AppLocalizations.of(context)!.or.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1!.merge(
                    const TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Row(
                  children: [
                    GFIconButton(
                      onPressed: () {},
                      size: GFSize.MEDIUM,
                      padding: const EdgeInsets.all(2),
                      icon: const FaIcon(FontAwesomeIcons.facebookF, size: 15.0,),
                    ),
                    const SizedBox(width: 10.0),
                    GFIconButton(
                      onPressed: () {},
                      size: GFSize.MEDIUM,
                      color:  const Color(0xFF000000),
                      splashColor: const Color(0xFF363636),
                      highlightColor: const Color(0xFF363636).withOpacity(0.6),
                      hoverColor: const Color(0xFF363636).withOpacity(0.6),
                      padding: const EdgeInsets.all(2),
                      icon: const FaIcon(FontAwesomeIcons.tiktok, size: 15.0,),
                    ),
                    const SizedBox(width: 10.0),
                    GFIconButton(
                      onPressed: () {},
                      size: GFSize.MEDIUM,
                      color: widget.palette.accentBrandColor(1.0),
                      splashColor: widget.palette.accentSplashColor(1.0),
                      highlightColor: widget.palette.accentSplashColor(0.6),
                      hoverColor: widget.palette.accentSplashColor(0.6),
                      padding: const EdgeInsets.all(2),
                      icon: const FaIcon(FontAwesomeIcons.google, size: 15.0,),
                    ),
                  ],
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
      // decoration: BoxDecoration(
      //   border: Border(
      //     bottom: BorderSide(
      //       width: 1.0,
      //       color:  widget.palette.borderColor(1.0),
      //     ),
      //   ),
      // ),
      child: Row(
        children: [
          const SizedBox(width: 4.0),
          Expanded(
            child: ScaffoldWidget.buildTitle(
              context,
              widget.palette,
              AppLocalizations.of(context)!.loginWith,
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
      return LoginWithEmailWidget();
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<SendOtpCodeBloc>(
          create: (context) => SendOtpCodeBloc(),
        )
      ],
      child: LoginWithTelephoneWidget(),
    );
  }
}