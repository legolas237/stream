import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_crop_plus/image_crop_plus.dart';

import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/app_bar_action/app_bar_action.dart';
import 'package:stream/widgets/app_scaffold/app_scaffold.dart';
import 'package:stream/widgets/link_button/link_button.dart';

// ignore: must_be_immutable
class CropperScreen extends StatefulWidget {
  CropperScreen({
    Key? key,
    required this.imageFile,
  }) : super(key: key);

  late Palette palette;

  final File imageFile;

  @override
  State<StatefulWidget> createState() => _CropperScreenState();
}

class _CropperScreenState extends State<CropperScreen> {
  final cropKey = GlobalKey<CropState>();
  late File? _lastCropped;
  late bool _canCrop;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _lastCropped = widget.imageFile;
    _canCrop = true;
  }

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.appTheme.palette;

    return ScaffoldWidget(
      title: ScaffoldWidget.buildTitle(
          context,
          widget.palette,
          AppLocalizations.of(context)!.cropped,
          widget.palette.whiteColor(1.0),
      ),
      centerTitle: true,
      automaticallyImplyLeading: true,
      backgroundColor: Colors.black,
      annotationRegion: widget.palette.secondaryBrandColor(1.0),
      appBarBackgroundColor: Colors.black,
      brightness: Brightness.light,
      leading: AppBarActionWidget(
        splashColor: widget.palette.secondarySplashColor(1),
        highLightColor: widget.palette.secondaryHighLightColor(1),
        icon: Icon(
          Icons.close_outlined,
          color: widget.palette.whiteColor(1),
          size: 22,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Container(
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: Crop.file(
                  _lastCropped!,
                  key: cropKey,
                  alwaysShowGrid: true,
                  onImageError: (data, _) {
                    _canCrop = false;
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 24.0, right: 10.0, bottom: 8.0, top: 8.0,
              ),
              color: widget.palette.secondaryBrandColor(1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LinkButtonWidget(
                    onTap: () {
                      if(_canCrop) _cropImage();
                    },
                    child: LinkButtonWidget.flatButtonTitle(
                      context,
                      AppLocalizations.of(context)!.save.toUpperCase(),
                      textStyle: Theme.of(context).textTheme.subtitle2!.merge(
                        TextStyle(
                          color: widget.palette.whiteColor(1.0),
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppBarActionWidget(
                        splashColor: widget.palette.secondarySplashColor(1.0),
                        highLightColor: widget.palette.secondaryHighLightColor(1.0),
                        icon: Icon(
                          Icons.refresh,
                          size: 22.0,
                          color: widget.palette.whiteColor(1.0),
                        ),
                        onPressed: () {
                          if(_canCrop) _resetImage();
                        },
                      ),
                      const SizedBox(width: 20.0),
                      AppBarActionWidget(
                        splashColor: widget.palette.secondarySplashColor(1.0),
                        highLightColor: widget.palette.secondaryHighLightColor(1.0),
                        icon: Icon(
                          Icons.check_outlined,
                          size: 22.0,
                          color: widget.palette.whiteColor(1.0),
                        ),
                        onPressed: () {
                          if(_canCrop) _applyCrop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _applyCrop() async {
    final scale = cropKey.currentState!.scale;
    final area = cropKey.currentState!.area;
    if (area == null) {
      // cannot crop, widget is not setup
      return;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger
    final sample = await ImageCrop.sampleImage(
      file: _lastCropped!,
      preferredSize: (2000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    sample.delete();

    setState(() {
      _lastCropped = file;
    });
  }

  void _cropImage() {
    Navigator.pop(context, _lastCropped);
  }

  void _resetImage() {
    setState(() {
      _lastCropped =  widget.imageFile;
    });
  }
}
