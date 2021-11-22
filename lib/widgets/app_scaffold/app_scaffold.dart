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
    this.titleColor,
    this.brightness = Brightness.dark,
    this.tabs,
    this.appBarBackgroundColor,
    this.annotationRegion,
    this.extendBodyBehindAppBar = false,
    this.resizeToAvoidBottomInset = true,
  }) : super(key: key);

  late Palette palette;

  final Widget body;
  final dynamic title;
  final Color? titleColor;
  final bool mainTitle;
  final bool withAppBar;
  final bool centerTitle;
  final List<Widget> actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? tabs;
  final Color? backgroundColor;
  final Color? appBarBackgroundColor;
  final Color? annotationRegion;
  final Brightness brightness;
  final bool extendBodyBehindAppBar;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    var color = backgroundColor;

    return AnnotationRegionWidget(
      color: annotationRegion ?? (color ?? palette.annotationRegionColor(1.0)),
      brightness: brightness,
      child: Scaffold(
        backgroundColor: color,
        appBar: withAppBar ? AppBar(
          backgroundColor: appBarBackgroundColor ?? palette.secondaryBrandColor(1.0),
          automaticallyImplyLeading: automaticallyImplyLeading,
          centerTitle: centerTitle,
          leading: leading,
          title: _buildTitle(context, title),
          actions: actions,
          bottom: tabs,
        ) : null,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      ),
    );
  }

  Widget _buildTitle(BuildContext context, dynamic title) {
    if(title is Widget) return title;

    if(title is String) {
      return Text(
        title,
        style: Theme.of(context).textTheme.subtitle1!.merge(
          TextStyle(
            color: titleColor ?? palette.whiteColor(1),
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Container();
  }
}
