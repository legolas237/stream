import 'package:flutter/material.dart';

import 'package:stream/screens/tabs_screen/widgets/bottom_tab_item.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class BottomTabWidget extends StatelessWidget {
  BottomTabWidget({
    Key? key,
    this.items = const <BottomTabItemWidget>[],
  }) : super(key: key);

  final List<BottomTabItemWidget> items;

  late Palette palette;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;
    
    return Card(
      margin: const EdgeInsets.all(0),
      color: palette.annotationRegionColor(1.0),
      elevation: 0.0,
      shape: const RoundedRectangleBorder(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        width: MediaQuery.of(context).size.width,
        height: 54,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items,
        ),
      ),
    );
  }
}
