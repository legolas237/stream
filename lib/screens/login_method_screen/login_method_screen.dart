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
class LoginMethodScreen extends StatefulWidget {
  static const routeName = '/login-method';

  LoginMethodScreen({Key? key}) : super(key: key);

  late Palette palette;

  @override
  State<StatefulWidget> createState() => _LoginMethodScreenState();
}

class _LoginMethodScreenState extends State<LoginMethodScreen> {
  late bool isSwitched;

  @override
  void initState() {
    super.initState();

    isSwitched = false;
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
      title: AppLocalizations.of(context)!.authMethod,
      body: BorderlessWrapperWidget(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConfigItemWidget(
                        title: AppLocalizations.of(context)!.usePassword,
                        subTitle: AppLocalizations.of(context)!.usePasswordNotice,
                        contentPadding: const EdgeInsets.only(
                          left: Constants.horizontalPadding,
                          right: 8.0,
                          top: 14.0,
                          bottom: 14.0,
                        ),
                        trailing: Switch(
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                            });
                          },
                          value: isSwitched,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          activeColor: widget.palette.secondaryBrandColor(0.8),
                          activeTrackColor: widget.palette.secondaryBrandColor(0.5),
                          inactiveThumbColor: widget.palette.scaffoldColor(1.0),
                          inactiveTrackColor: widget.palette.captionColor(0.3),
                        ),
                        onTap: () {
                          setState(() {
                            isSwitched = !isSwitched;
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
          )
      ),
    );
  }
}