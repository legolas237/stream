import 'package:photo_manager/photo_manager.dart';

import 'package:stream/models/util/asset_entity_data.dart';

class AssetPathEntityData {
  AssetPathEntityData({
    required this.entityPath,
    required this.assets,
    this.imageCount = 0,
    this.videoCount = 0,
  });

  final int? imageCount;
  final int? videoCount;
  final AssetPathEntity entityPath;
  final List<AssetEntityData> assets;
}
