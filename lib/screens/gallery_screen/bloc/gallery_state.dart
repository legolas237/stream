part of 'gallery_bloc.dart';

enum GalleryStatus {
  initial,
  intermediate,
  fetching,
  fetched,
}

@immutable
class GalleryState extends Equatable {
  GalleryState({
    this.status = GalleryStatus.initial,
    this.assets = const <AssetPathEntityData>[],
  });

  final GalleryStatus status;
  final List<AssetPathEntityData> assets;

  @override
  List<Object?> get props => [status, assets];

  GalleryState copyWith({
    GalleryStatus? status,
    List<AssetPathEntityData>? assets,
  }) {
    return GalleryState(
      status: status ?? this.status,
      assets: assets ?? this.assets,
    );
  }

  @override
  String toString() => 'GalleryState {status: $status}';
}
