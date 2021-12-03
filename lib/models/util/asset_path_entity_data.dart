import 'package:photo_manager/photo_manager.dart';

class AssetPathEntityData {
  AssetPathEntityData({
    required this.entityPath,
    required this.assets,
  });

  final AssetPathEntity entityPath;
  final List<AssetEntity> assets;
}
