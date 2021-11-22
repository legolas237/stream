import 'package:flutter/material.dart';

import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class DividerWidget extends StatelessWidget {
  DividerWidget({
    Key? key,
  }) : super(key: key);

  late Palette palette;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    return Divider(color: palette.borderColor(1.0), height: 1.0,);
  }
}
