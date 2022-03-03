import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:stream/config/hooks.dart';

import 'package:stream/models/util/asset_entity_data.dart';
import 'package:stream/screens/gallery_screen/bloc/gallery_bloc.dart';
import 'package:stream/screens/gallery_screen/gallery_screen.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class AssetItemWidget extends StatelessWidget {
  AssetItemWidget({
    Key? key,
    required this.asset,
    this.onSelect,
    this.isSelected = false,
  }) : super(key: key);

  late Palette palette;

  final bool isSelected;
  final AssetEntityData asset;
  final Function(AssetEntity)? onSelect;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    return _buildAssets(context);
  }

  // Renders

  Widget _assetScaffold({required List<Widget> Function(BuildContext context, AsyncSnapshot snapshot,) callback,}) {
    return GestureDetector(
      onTap: () {
        if(onSelect != null) onSelect!(asset.entity);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
        child: FutureBuilder<Uint8List?>(
          future: asset.entity.thumbData,
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done){
              return SizedBox(
                height: MediaQuery.of(context).size.width * 0.27,
                width: MediaQuery.of(context).size.width * 0.27,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    ...callback(context, snapshot),
                  ],
                ),
              );
            }

            return _placeHolder(context);
          },
        ),
      ),
    );
  }

  Widget _buildAssets(BuildContext context) {
    var bloc = BlocProvider.of<GalleryBloc>(context);

    if(bloc.galleryMode == GalleryMode.video) {
      if(asset.entity.type == AssetType.video) {
        return _assetScaffold(
          callback: _videoAssets,
        );
      }
    }

    if(bloc.galleryMode == GalleryMode.photo) {
      if(asset.entity.type == AssetType.image) {
        return _assetScaffold(
          callback: _imageAssets,
        );
      }
    }

    if(bloc.galleryMode == GalleryMode.mixed) {
      if(asset.entity.type == AssetType.image) {
        return _assetScaffold(
          callback: _imageAssets,
        );
      }

      if(asset.entity.type == AssetType.video) {
        return _assetScaffold(
          callback: _videoAssets,
        );
      }
    }

    return const SizedBox();
  }

  List<Widget> _imageAssets(BuildContext context, AsyncSnapshot snapshot,) {
    return [
      Positioned.fill(
        child: Image.memory(
          snapshot.data!,
          fit: BoxFit.cover,
        ),
      ),
      if(isSelected) Align(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            color: palette.whiteColor(1.0),
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(6.0),
          child: Icon(
            Icons.check,
            size: 16.0,
            color: palette.textColor(1.0),
          ),
        ),
      ),
      if(isSelected) Container(color: palette.whiteColor(0.2)),
    ];
  }

  List<Widget> _videoAssets(BuildContext context, AsyncSnapshot snapshot,) {
    return [
      Positioned.fill(
        child: Image.memory(
          snapshot.data!,
          fit: BoxFit.cover,
        ),
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.videocam,
                size: 20.0,
                color: palette.whiteColor(1.0),
              ),
              const SizedBox(width: 10.0),
              Text(
                Hooks.readableDuration(asset.entity.videoDuration),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1!.merge(
                  TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w500,
                    color: palette.whiteColor(1.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      if(isSelected) Align(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            color: palette.whiteColor(1.0),
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(6.0),
          child: Icon(
            Icons.check,
            size: 16.0,
            color: palette.textColor(1.0),
          ),
        ),
      ),
      if(isSelected) Container(color: palette.whiteColor(0.2)),
    ];
  }

   Widget _placeHolder(BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.width * 0.27,
        width: MediaQuery.of(context).size.width * 0.27,
        decoration: BoxDecoration(
          color: palette.borderColor(0.6),
          border: Border.all(
            color: palette.borderColor(1.0),
            width: 1.0,
          ),
        ),
      );
   }
}