import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stream/config/config.dart';
import 'package:stream/models/util/asset_path_entity_data.dart';
import 'package:stream/screens/gallery_screen/bloc/gallery_bloc.dart';
import 'package:stream/screens/gallery_screen/gallery_screen.dart';
import 'package:stream/screens/gallery_screen/widgets/asset_item.dart';
import 'package:stream/screens/gallery_screen/widgets/asset_list_item.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class AssetPathItemWidget extends StatelessWidget {
  AssetPathItemWidget({
    Key? key,
    required this.data,
    this.onSelect,
    required this.displayMode,
  }) : super(key: key);

  late Palette palette;

  final DisplayMode displayMode;
  final AssetPathEntityData data;
  final Function(AssetEntity)? onSelect;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: Constants.horizontalPadding,
            right: Constants.minHorizontalPadding,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  data.entityPath.name.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle2!.merge(
                    TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 11.0,
                      color: palette.captionColor(1.0),
                    ),
                  ),
                ),
              ),
              Text(
                _buildCountTitle(context),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle2!.merge(
                  TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 11.0,
                    color: palette.secondaryBrandColor(1.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        _buildAssets(context),
      ],
    );
  }

  // Renders

  Widget _buildAssets(BuildContext context) {
    var bloc = BlocProvider.of<GalleryBloc>(context);

    if(displayMode == DisplayMode.list) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...data.assets.map((item) {
            return AssetListItemWidget(
              asset: item,
              onSelect: onSelect,
              isSelected: bloc.state.isSelected(item.entity),
            );
          }).toList(),
          const SizedBox(height: 10.0),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.only(
        left: Constants.horizontalPadding,
        right: Constants.minHorizontalPadding,
        top: 10.0,
        bottom: 14.0,
      ),
      child: Wrap(
        children: [
          ...data.assets.map((item) {
            return AssetItemWidget(
              asset: item,
              onSelect: onSelect,
              isSelected: bloc.state.isSelected(item.entity),
            );
          }).toList(),
          if (data.entityPath.assetCount > Constants.galleryPerPage) _moreWrapper(context),
        ],
      )
    );
  }

  String _buildCountTitle(BuildContext context) {
    var bloc = BlocProvider.of<GalleryBloc>(context);

    if(bloc.galleryMode == GalleryMode.video) {
      return data.videoCount.toString();
    }

    if(bloc.galleryMode == GalleryMode.photo) {
      return data.imageCount.toString();
    }

    return data.entityPath.assetCount.toString();
  }

  Widget _moreWrapper(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: palette.borderColor(0.2),
        border: Border.all(
          color: palette.borderColor(0.4),
          width: 1.0,
        ),
      ),
      child: Text(
        AppLocalizations.of(context)!.more.toUpperCase(),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.subtitle2!.merge(
          TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w500,
            color: palette.captionColor(1.0),
          ),
        ),
      ),
    );
  }
}
