import 'package:camera/camera.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';

import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/annotation_region/annotation_region.dart';

// ignore: must_be_immutable
class UseCameraScreen extends StatefulWidget {
  UseCameraScreen({
    Key? key,
  }) : super(key: key);

  late Palette palette;

  @override
  State<StatefulWidget> createState() => _UseCameraScreenState();
}

class _UseCameraScreenState extends State<UseCameraScreen> {
  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.appTheme.palette;

    return AnnotationRegionWidget(
      brightness: Brightness.light,
      color: widget.palette.secondaryBrandColor(1.0),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: CameraCamera(
            resolutionPreset: ResolutionPreset.high,
            onFile: (file) {
              Navigator.pop(context, file);
            },
        ),
      ),
    );
  }
}