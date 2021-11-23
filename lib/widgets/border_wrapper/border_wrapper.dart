import 'package:flutter/material.dart';

import 'package:stream/theme/theme_provider.dart';

class BorderlessWrapperWidget extends StatelessWidget {
  const BorderlessWrapperWidget({
    Key? key,
    required this.child,
    this.bottom = true,
    this.top = true,
    this.padding = const EdgeInsets.symmetric(vertical: 0.0),
    this.color = Colors.transparent,
  }) : super(key: key);

  final Widget child;
  final bool bottom;
  final bool top;
  final EdgeInsets padding;
  final Color color;

  @override
  Widget build(BuildContext context) {
    var border = BorderSide(
      color: ThemeProvider.of(
        context,
      )!.appTheme.palette.borderColor(0.6),
      width: 1,
    );

    var noneBorder = const BorderSide(
      color: Colors.transparent,
      width: 0.0,
    );

    return Container(
      padding: padding,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: color,
        border: Border(
          top: top ? border : noneBorder,
          bottom: bottom ? border : noneBorder,
        ),
      ),
      child: child,
    );
  }
}
