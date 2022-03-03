import 'package:basic_utils/basic_utils.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path/path.dart';
import 'package:stream/config/hooks.dart';
import 'dart:typed_data';

import 'package:stream/models/util/asset_entity_data.dart';
import 'package:stream/screens/gallery_screen/bloc/gallery_bloc.dart';
import 'package:stream/screens/gallery_screen/gallery_screen.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/list_tile_item/list_tile_item.dart';

// ignore: must_be_immutable
class AssetListItemWidget extends StatelessWidget {
  AssetListItemWidget({
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

  Widget _assetScaffold(BuildContext context) {
    return ListTileItemWidget(
      onTap: () {
        if(onSelect != null) onSelect!(asset.entity);
      },
      tileColor: isSelected ? palette.secondaryBrandColor(0.1) : null,
      leading: !isSelected ? _buildLeading(context) : Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.width * 0.12,
        width: MediaQuery.of(context).size.width * 0.12,
        child: Icon(
          Icons.check_circle,
          size: 22.0,
          color: palette.secondaryBrandColor(1.0),
        ),
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListTileItemWidget.buttonTitle(
              palette: palette,
              context: context,
              text: asset.entity.title != null ? asset.entity.title!.split('.').first : AppLocalizations.of(context)!.unknown,
            ),
          ),
          if(asset.entity.type == AssetType.video) Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              Hooks.readableDuration(asset.entity.videoDuration),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption!.merge(
                const TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      subtitle: ListTileItemWidget.buttonSubTitle(
        palette: palette,
        context: context,
        text: _listTileSubTitle(context),
      ),
    );
  }

  Widget _buildLeading(BuildContext context) {
    if(asset.entity.type == AssetType.image) {
      return _imageAssets(context);
    }

    if(asset.entity.type == AssetType.video) {
      return _videoAssets(context);
    }

    if(asset.entity.type == AssetType.audio) {
      return _audioAssets(context);
    }

    return Icon(
      Icons.insert_drive_file_outlined,
      size: 20.0,
      color: palette.secondaryBrandColor(1.0),
    );
  }

  Widget _buildAssets(BuildContext context) {
    var bloc = BlocProvider.of<GalleryBloc>(context);

    if(bloc.galleryMode == GalleryMode.video) {
      if(asset.entity.type == AssetType.video) {
        return _assetScaffold(context);
      }
    }

    if(bloc.galleryMode == GalleryMode.photo) {
      if(asset.entity.type == AssetType.image) {
        return _assetScaffold(context);
      }
    }

    return _assetScaffold(context);
  }

  Widget _imageAssets(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: asset.entity.thumbData,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done){
          return SizedBox(
            height: MediaQuery.of(context).size.width * 0.12,
            width: MediaQuery.of(context).size.width * 0.12,
            child: Image.memory(
              snapshot.data!,
              fit: BoxFit.cover,
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _audioAssets(BuildContext context) {
    return const Icon(
      Icons.audiotrack_outlined,
      size: 20.0,
      color: Colors.redAccent,
    );
  }

  Widget _videoAssets(BuildContext context) {
    return const Icon(
      Icons.videocam_outlined,
      size: 20.0,
      color: Colors.green,
    );
  }

  String _listTileSubTitle(BuildContext context) {
    String size = '';
    String ext = '';

    if(asset.size != null) {
      size = filesize(asset.size);
    }

    if(asset.file != null) {
      ext = extension(asset.file!.path).toUpperCase().replaceFirst(".", "");
    }

    return '${StringUtils.isNotNullOrEmpty(ext) ? '$ext'  : ''}${StringUtils.isNotNullOrEmpty(size) ? ', $size'  : ''}';
  }
}