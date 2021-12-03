import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stream/config/config.dart';
import 'package:stream/models/util/asset_path_entity_data.dart';
import 'package:stream/screens/gallery_screen/widgets/asset_item.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class AssetPathItemWidget extends StatelessWidget {
  AssetPathItemWidget({
    Key? key,
    required this.data,
    this.onSelect,
  }) : super(key: key);

  late Palette palette;

  final AssetPathEntityData data;
  final Function(AssetEntity)? onSelect;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.appTheme.palette;

    return Container(
      padding: const EdgeInsets.only(
        left: Constants.horizontalPadding,
        right: Constants.horizontalPadding,
        bottom: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                data.entityPath.assetCount.toString(),
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
          const SizedBox(height: 20.0),
          Wrap(
            children: [
              ...data.assets.map((item) {
                return AssetItemWidget(
                  asset: item,
                  onSelect: onSelect,
                );
              }).toList(),
              if (data.entityPath.assetCount > Constants.galleryPerPage)
                _moreWrapper(context),
            ],
          ),
        ],
      ),
    );
  }

  // Renders

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
