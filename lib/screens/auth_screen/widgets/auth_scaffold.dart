import 'package:flutter/material.dart';
import 'package:stream/config/config.dart';

import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/app_scaffold/app_scaffold.dart';
import 'package:stream/widgets/border_wrapper/border_wrapper.dart';

// ignore: must_be_immutable
class AuthScaffoldWidget extends StatelessWidget {
  AuthScaffoldWidget({
    Key? key,
    required this.contentAppBar,
    required this.contentBottom,
    required this.content,
    this.resizeToAvoidBottomInset = false,
  }) : super(key: key);

  late Palette palette;

  final Widget contentAppBar;
  final Widget contentBottom;
  final Widget content;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    return ScaffoldWidget(
      backgroundColor: palette.scaffoldColor(1.0),
      appBarBackgroundColor: palette.scaffoldColor(1.0),
      annotationRegion: palette.annotationRegionColor(1.0),
      automaticallyImplyLeading: false,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      centerTitle: false,
      title: contentAppBar,
      body: BorderlessWrapperWidget(
        bottom: false,
        top: true,
        child: Column(
          children: [
            Expanded(
              child: content,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.horizontalPadding,
                vertical: Constants.verticalPadding,
              ),
              child: contentBottom,
            ),
          ],
        ),
      ),
    );
  }
}