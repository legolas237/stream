import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stream/config/config.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/app_bar_action/app_bar_action.dart';
import 'package:stream/widgets/app_scaffold/app_scaffold.dart';
import 'package:stream/widgets/border_wrapper/border_wrapper.dart';
import 'package:stream/widgets/config_item/congig_item.dart';

// ignore: must_be_immutable
class LanguageChooserScreen extends StatefulWidget {
  static const routeName = '/language-chooser';

  LanguageChooserScreen({Key? key}) : super(key: key);

  late Palette palette;

  @override
  State<StatefulWidget> createState() => _LanguageChooserScreenState();
}

class _LanguageChooserScreenState extends State<LanguageChooserScreen> {
  late int selected;

  @override
  void initState() {
    super.initState();

    selected = 1;
  }

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.appTheme.palette;

    return ScaffoldWidget(
      automaticallyImplyLeading: true,
      centerTitle: false,
      leading: AppBarActionWidget(
        icon: AppBarActionWidget.buildIcon(
          icon: Icons.close,
          color: widget.palette.iconColor(1),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: AppLocalizations.of(context)!.selectLanguage,
      body: BorderlessWrapperWidget(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4.0),
                      ConfigItemWidget(
                        title: AppLocalizations.of(context)!.english,
                        subTitle: AppLocalizations.of(context)!.englishEnglang,
                        leading: Image.asset(
                          'icons/flags/png/gb.png',
                          package: "country_icons",
                          width: 18.0,
                          height: 20.0,
                        ),
                        withBorder: true,
                        trailing: Container(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Icon(
                            Icons.radio_button_checked_outlined,
                            color: selected == 1 ? widget.palette.secondaryBrandColor(1.0) : widget.palette.captionColor(0.2),
                            size: 20.0,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            selected = 1;
                          });
                        },
                      ),
                      ConfigItemWidget(
                        title: AppLocalizations.of(context)!.french,
                        subTitle: AppLocalizations.of(context)!.frenchFrance,
                        leading: Image.asset(
                          'icons/flags/png/fr.png',
                          package: "country_icons",
                          width: 18.0,
                          height: 20.0,
                        ),
                        withBorder: true,
                        trailing: Container(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Icon(
                            Icons.radio_button_checked_outlined,
                            color: selected == 2 ? widget.palette.secondaryBrandColor(1.0) : widget.palette.captionColor(0.2),
                            size: 20.0,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            selected = 2;
                          });
                        },
                      ),
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
                          AppLocalizations.of(context)!
                              .clickToContinue
                              .toUpperCase(),
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
