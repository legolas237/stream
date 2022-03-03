import 'package:flutter/material.dart';

import 'package:stream/config/config.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class ConfigItemWidget extends StatelessWidget {
  ConfigItemWidget({
    Key? key,
    required this.title,
    this.subTitle,
    this.titleStyle,
    required this.onTap,
    this.contentPadding: const EdgeInsets.only(
      right: Constants.horizontalPadding,
      left: Constants.horizontalPadding,
      top: 14.0,
      bottom: 14.0,
    ),
    this.leading,
    this.trailing,
    this.withBorder = false,
    this.extra,
  }) : super(key: key);

  late Palette palette;

  final Widget? leading;
  final Widget? trailing;
  final String title;
  final String? subTitle;
  final Widget? extra;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry? contentPadding;
  final bool withBorder;

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    var border = BorderSide(
      color: ThemeProvider.of(
        context,
      )!.appTheme.palette.borderColor(0.6),
      width: 1,
    );

    var noneBorder = const BorderSide(
      color: Colors.transparent,
      width: 1.0,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: palette.splashLightColor(1),
        highlightColor: palette.highLightLightColor(1),
        hoverColor: palette.highLightLightColor(1),
        onTap: onTap,
        child: Container(
          padding: contentPadding,
          decoration: BoxDecoration(
            border: Border(
              bottom: withBorder ? border : noneBorder,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              leading != null
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.16,
                      alignment: Alignment.centerLeft,
                      child: leading,
                    )
                  : const SizedBox(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: titleStyle ??
                          Theme.of(
                            context,
                          ).textTheme.subtitle1!.merge(
                                const TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                    ),
                    subTitle == null
                        ? const SizedBox(height: 0)
                        : Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              subTitle!,
                              style: Theme.of(context).textTheme.caption!.merge(
                                    const TextStyle(
                                      fontSize: 11.8,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                            ),
                          ),
                    extra ?? const SizedBox(),
                  ],
                ),
              ),
              trailing != null
                  ? Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(left: 10.0),
                      child: trailing,
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
