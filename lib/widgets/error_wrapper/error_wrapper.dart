import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/button/button.dart';

// ignore: must_be_immutable
class ErrorWrapperWidget extends StatelessWidget {
  ErrorWrapperWidget({
    Key? key,
    this.title,
    this.subTitle,
    this.callback,
    this.actionTitle,
    this.assetImage,
  }) : super(key: key);

  late Palette palette;

  final String? assetImage;
  final String? title;
  final String? subTitle;
  final String? actionTitle;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          assetImage != null
              ? Image.asset(
                  assetImage!,
                  width: MediaQuery.of(context).size.width * 0.32,
                  height: MediaQuery.of(context).size.width * 0.32,
                )
              : Container(),
          const SizedBox(height: 10.0),
          StringUtils.isNotNullOrEmpty(title)
              ? Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1!.merge(
                        const TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                )
              : Container(),
          const SizedBox(height: 6.0),
          subTitle != null
              ? Text(
                  subTitle!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption!.merge(
                        const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                )
              : Container(),
          const SizedBox(height: 22.0),
          callback != null
              ? ButtonWidget(
                  onPressed: () {
                    if (callback != null) {
                      callback!();
                    }
                  },
                  enabled: true,
                  child: ButtonWidget.buttonTextChild(
                    context: context,
                    enabled: true,
                    text: actionTitle ?? AppLocalizations.of(context)!.retry,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
