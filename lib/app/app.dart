import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:statusbarz/statusbarz.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stream/blocs/localization/localization_cubit.dart';
import 'package:stream/blocs/theme/theme_cubit.dart';
import 'package:stream/config/config.dart';
import 'package:stream/routes/route_generator.dart';
import 'package:stream/screens/init_screen/init_screen.dart';
import 'package:stream/theme/ostream_app_theme.dart';
import 'package:stream/theme/theme_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localizationCubit = BlocProvider.of<LocalizationCubit>(
      context,
      listen: true,
    );
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    OStreamAppTheme theme = OStreamAppTheme(
      isDark: themeCubit.state.status == ThemeStatusEnum.dark,
    );
    print("App language : ${localizationCubit.state.language}");

    return ThemeProvider(
      appTheme: theme,
      child: StatusbarzCapturer(
        child: MaterialApp(
          title: Constants.appName,
          // Theme
          theme: theme.defaultTheme(context),
          darkTheme: theme.defaultTheme(context),
          // Language
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: Locale(
            localizationCubit.state.language.toLowerCase(),
            '',
          ),
          supportedLocales: const [
            Locale('en', ''),
            Locale('fr', ''),
          ],
          // Rest
          initialRoute: _redirect(context),
          onGenerateRoute: RouteGenerator.generateRoute,
          debugShowCheckedModeBanner: false,
          navigatorObservers: [Statusbarz.instance.observer],
        ),
      ),
    );
  }

  String _redirect(BuildContext context) {
    return InitScreen.routeName;
  }
}
