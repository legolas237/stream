import 'package:flutter/material.dart';

import 'package:stream/screens/auth_screen/widgets/auth_tab_item.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class AuthTabWidget extends StatelessWidget {
  AuthTabWidget({
    Key? key,
    required this.items,
  }) : super(key: key);

  late Palette palette;

  final List<AuthTabItemWidget> items;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    return Row(
      children: items,
    );
  }
}