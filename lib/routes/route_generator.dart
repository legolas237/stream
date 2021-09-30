import 'package:flutter/material.dart';

import 'package:stream/screens/init_screen/init_screen.dart';
import 'package:stream/widgets/app_bar_action/app_bar_action.dart';
import 'package:stream/widgets/app_scaffold/app_scaffold.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case InitScreen.routeName:
        return MaterialPageRoute(builder: (_) => InitScreen());
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
          title: 'Error',
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
}
