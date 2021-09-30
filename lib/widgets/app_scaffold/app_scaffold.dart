import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:stream/widgets/annotation_region/annotation_region.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class ScaffoldWidget extends StatelessWidget {
  ScaffoldWidget({
    Key? key,
    required this.body,
    this.title,
    this.centerTitle = true,
    this.actions = const <Widget>[],
    this.mainTitle = false,
    this.automaticallyImplyLeading = true,
    this.bottomNavigationBar,
    this.leading,
    this.backgroundColor,
    this.withAppBar = true,
    this.appChild,
    this.titleColor,
    this.brightness = Brightness.dark,
  }) : super(key: key);

  late Palette palette;

  final Widget body;
  final String? title;
  final Color? titleColor;
  final bool mainTitle;
  final bool withAppBar;
  final bool centerTitle;
  final List<Widget> actions;
  final Widget? leading;
  final Widget? appChild;
  final bool automaticallyImplyLeading;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    var color = backgroundColor;

    return AnnotationRegionWidget(
      color: color ?? palette.scaffoldColor(1),
      brightness: brightness,
      child: Scaffold(
        backgroundColor: color,
        appBar: withAppBar ? AppBar(
          backgroundColor: color,
          automaticallyImplyLeading: automaticallyImplyLeading,
          centerTitle: centerTitle,
          leading: leading,
          title: title != null
              ? Text(
                  title!,
                  style: Theme.of(context).textTheme.subtitle1!.merge(
                    TextStyle(
                      color: titleColor ?? palette.whiteColor(1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : appChild ?? Container(),
          actions: actions,
        ) : null,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
