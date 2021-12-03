import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class AssetItemWidget extends StatelessWidget {
  AssetItemWidget({
    Key? key,
    required this.asset,
    this.onSelect,
  }) : super(key: key);

  late Palette palette;

  final AssetEntity asset;
  final Function(AssetEntity)? onSelect;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    return GestureDetector(
      onTap: () {
        if(onSelect != null && asset.type == AssetType.image) onSelect!(asset);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
        child: FutureBuilder<Uint8List?>(
          future: asset.thumbData,
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done){
              return Container(
                height: 84, width: 84,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.memory(
                        snapshot.data!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (asset.type == AssetType.video) Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 5, bottom: 5),
                        child: Icon(
                          Icons.videocam,
                          size: 20.0,
                          color: palette.whiteColor(1.0),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return _placeHolder();
          },
        ),
      )
    );
  }

  // Renders

   Widget _placeHolder() {
      return Container(
        height: 84, width: 84,
        decoration: BoxDecoration(
          color: palette.borderColor(0.2),
          border: Border.all(
            color: palette.borderColor(0.4),
            width: 1.0,
          ),
        ),
      );
   }
}