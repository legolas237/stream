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