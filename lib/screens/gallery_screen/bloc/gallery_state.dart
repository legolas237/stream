part of 'gallery_bloc.dart';

enum GalleryStatus {
  initial,
  intermediate,
  fetching,
  fetched,
}

@immutable
class GalleryState extends Equatable {
  const GalleryState({
    this.status = GalleryStatus.initial,
    this.assets = const <AssetPathEntityData>[],
    this.selectedAssets = const <AssetEntity>[],
    this.assetEntities = const <AssetEntity>[],
  });

  final GalleryStatus status;
  final List<AssetPathEntityData> assets;
  final List<AssetEntity> assetEntities;
  final List<AssetEntity> selectedAssets;

  @override
  List<Object?> get props => [status, assets, selectedAssets,];

  GalleryState copyWith({
    GalleryStatus? status,
    List<AssetPathEntityData>? assets,
    List<AssetEntity>? selectedAssets,
    List<AssetEntity>? assetEntities,
  }) {
    return GalleryState(
      status: status ?? this.status,
      assets: assets ?? this.assets,
      selectedAssets: selectedAssets ?? this.selectedAssets,
      assetEntities: assetEntities ?? this.assetEntities,
    );
  }

  @override
  String toString() => 'GalleryState {status: $status}';

  // Utilities

  bool isSelected(AssetEntity asset) {
    var assetIndex = selectedAssets.indexWhere((item) => item.id == asset.id);

    return assetIndex >= 0;
  }
}
