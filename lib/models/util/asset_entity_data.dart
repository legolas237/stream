import 'dart:io';
import 'package:photo_manager/photo_manager.dart';

class AssetEntityData {
  AssetEntityData({
    required this.entity,
    this.size,
    this.file,
  });

  final File? file;
  final int? size;
  final AssetEntity entity;
}
