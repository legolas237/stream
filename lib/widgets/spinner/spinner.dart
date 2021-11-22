import 'package:flutter/material.dart';

import 'package:stream/theme/palette.dart';

const Color color = Palette.secondary;

class SpinnerWidget extends StatelessWidget {
  const SpinnerWidget({
    Key? key,
    this.backgroundColor = Colors.transparent,
    this.strokeWidth = 2.4,
    this.colors = const AlwaysStoppedAnimation<Color>(color),
  }) : super(key: key);

  final Color backgroundColor;
  final double strokeWidth;
  final Animation<Color> colors;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      key: key,
      backgroundColor: backgroundColor,
      strokeWidth: strokeWidth,
      valueColor: colors,
    );
  }
}
