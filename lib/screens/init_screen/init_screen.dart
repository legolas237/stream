import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stream/config/config.dart';
import 'package:stream/config/hooks.dart';
import 'package:stream/screens/init_screen/bloc/start_bloc.dart';
import 'package:stream/screens/introduction_screen/introduction_screen.dart';
import 'package:stream/screens/tabs_screen/tabs_screen.dart';
import 'package:stream/screens/unlock_screen/unlock_screen.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/app_scaffold/app_scaffold.dart';

// ignore: must_be_immutable
class InitScreen extends StatelessWidget {
  static const routeName = '/';

  InitScreen({Key? key}) : super(key: key);

  late Palette palette;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    BlocProvider.of<StartBloc>(context).add(StartReady());

    return ScaffoldWidget(
      backgroundColor: palette.scaffoldColor(1.0),
      appBarBackgroundColor: palette.scaffoldColor(1.0),
      annotationRegion: palette.scaffoldColor(1.0),
      body: BlocConsumer<StartBloc, StartState>(
        listener: (context, state) {
          if(state is StartApp) {
            Navigator.of(context).pushNamedAndRemoveUntil(TabsScreen.routeName, (route) => false,);
          } else {
            Navigator.of(context).pushNamedAndRemoveUntil(IntroScreen.routeName, (route) => false,);
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 52.0,
                        width: 52.0,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/launcher_for_init.png"
                              ),
                              fit: BoxFit.fitHeight,
                            )
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.subtitle1!.merge(
                            const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'O\'',
                              style: TextStyle(color: palette.secondaryBrandColor(1.0),),
                            ),
                            const TextSpan(
                              text: ' Stream',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Constants.horizontalPadding,
                  vertical: Constants.horizontalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Copyright © ${Hooks.formatDate(DateTime.now(), 'yyyy')}',
                      style: Theme.of(context).textTheme.caption!.merge(
                        const TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'RICHy INC',
                      style: Theme.of(context).textTheme.subtitle1!.merge(
                        TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: palette.secondaryBrandColor(1.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}