import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stream/config/config.dart';
import 'package:stream/screens/global_config_screen/widgets/congig_item.dart';
import 'package:stream/screens/language_chooser_screen/language_chooser_screen.dart';
import 'package:stream/screens/login_method_screen/login_method_screen.dart';
import 'package:stream/screens/theme_chooser_screen/theme_chooser_screen.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/annotation_region/annotation_region.dart';
import 'package:stream/widgets/app_bar_action/app_bar_action.dart';
import 'package:stream/widgets/border_wrapper/border_wrapper.dart';

// ignore: must_be_immutable
class GlobalConfigScreen extends StatelessWidget {
  static const routeName = '/global-config';

  GlobalConfigScreen({Key? key}) : super(key: key);

  late Palette palette;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    return AnnotationRegionWidget(
      color: palette.scaffoldColor(1),
      brightness: Brightness.dark,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: palette.scaffoldColor(1.0),
          automaticallyImplyLeading: true,
          centerTitle: true,
          leading: AppBarActionWidget(
            icon: AppBarActionWidget.buildIcon(
              icon: Icons.close,
              color: palette.iconColor(1),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "O'",
                  style: Theme.of(context).textTheme.subtitle2!.merge(
                    TextStyle(
                      color: palette.secondaryBrandColor(1.0),
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                TextSpan(
                  text: "Stream",
                  style: Theme.of(context).textTheme.subtitle2!.merge(
                    TextStyle(
                      color: palette.primaryBrandColor(1.0),
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.27,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/images/global_config_illustration.png"
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 30.0,
                        )
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Constants.horizontalPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.globalConfigMessage,
                            style: Theme.of(context).textTheme.subtitle2!.merge(
                              const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            AppLocalizations.of(context)!.globalConfigMessageNotice,
                            style: Theme.of(context).textTheme.caption!.merge(
                              const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ConfigItemWidget(
                      icon: Icons.language,
                      title: AppLocalizations.of(context)!.language,
                      subTitle: AppLocalizations.of(context)!.english,
                      extraContent: Icon(
                        Icons.chevron_right,
                        color: palette.captionColor(1.0),
                        size: 18.0,
                      ),
                      withBorder: true,
                      onTap: () {
                        Navigator.pushNamed(context, LanguageChooserScreen.routeName,);
                      },
                    ),
                    ConfigItemWidget(
                      icon: Icons.lock_open_outlined,
                      title: AppLocalizations.of(context)!.authMethod,
                      subTitle: AppLocalizations.of(context)!.usePassword,
                      extraContent: Icon(
                        Icons.chevron_right,
                        color: palette.captionColor(1.0),
                        size: 18.0,
                      ),
                      withBorder: true,
                      onTap: () {
                        Navigator.pushNamed(context, LoginMethodScreen.routeName,);
                      },
                    ),
                    ConfigItemWidget(
                      icon: Icons.brightness_4_outlined,
                      title: AppLocalizations.of(context)!.theme,
                      subTitle: AppLocalizations.of(context)!.defaultTheme,
                      extraContent: Icon(
                        Icons.chevron_right,
                        color: palette.captionColor(1.0),
                        size: 18.0,
                      ),
                      withBorder: false,
                      onTap: () {
                        Navigator.pushNamed(context, ThemeChooserScreen.routeName,);
                      },
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
            BorderlessWrapperWidget(
              bottom: false,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Constants.horizontalPadding,
                  vertical: 15.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        AppLocalizations.of(context)!.clickToContinue.toUpperCase(),
                        style: Theme.of(context).textTheme.headline2!.merge(
                          const TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}