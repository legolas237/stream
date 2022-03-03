part of 'gallery_bloc.dart';

@immutable
abstract class GalleryEvent extends Equatable {
  const GalleryEvent();

  @override
  List<Object?> get props => [];
}

class FetchAssets extends GalleryEvent {
  @override
  String toString() => 'FetchAlbums';
}

class SelectAsset extends GalleryEvent {
  const SelectAsset({
    required this.asset,
  });

  final AssetEntity asset;

  @override
  String toString() => 'SelectAsset';

  @override
  List<Object?> get props => [asset];
}
