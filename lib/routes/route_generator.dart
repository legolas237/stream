import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stream/screens/auth_screen/auth_screen.dart';
import 'package:stream/screens/init_screen/init_page_bloc_provider.dart';
import 'package:stream/screens/init_screen/init_screen.dart';
import 'package:stream/screens/introduction_screen/introduction_screen.dart';
import 'package:stream/screens/signup_screen/signup_screen.dart';
import 'package:stream/widgets/app_bar_action/app_bar_action.dart';
import 'package:stream/widgets/app_scaffold/app_scaffold.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case InitScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const InitScreenBlocProvider(),
        );
      case IntroScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => IntroScreen(),
        );
      case AuthScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => AuthScreen(),
        );
      case SignupScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => SignupScreen(),
        );
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _notFoundRoute();
    }
  }

  static Route<dynamic> _notFoundRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return ScaffoldWidget(
          centerTitle: true,
          title: AppLocalizations.of(context)!.oopsError,
          leading: AppBarActionWidget(
            icon: const Icon(
              Icons.close,
              size: 20.0,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          body: const Center(
            child: Text(
              'PAGE NOT FOUND',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
        );
      },
    );
  }

  static Route _createTransitionRoute({required Widget screen}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
