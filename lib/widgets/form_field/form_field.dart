import 'package:flutter/material.dart';

import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class FormFieldWidget extends StatelessWidget {
  FormFieldWidget({Key? key}) : super(key: key);

  late Palette palette;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    return TextFormField();
  }
}