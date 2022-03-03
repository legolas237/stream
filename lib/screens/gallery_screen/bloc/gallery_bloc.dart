import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter/foundation.dart';

import 'package:stream/config/config.dart';
import 'package:stream/models/util/asset_entity_data.dart';
import 'package:stream/models/util/asset_path_entity_data.dart';
import 'package:stream/screens/gallery_screen/gallery_screen.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc({
    required this.galleryMode,
  }) : super(GalleryState());

  final GalleryMode? galleryMode;

  @override
  Stream<GalleryState> mapEventToState(GalleryEvent event) async* {
    if (event is FetchAssets) {
      yield* _mapFetchAssetsToState(event);
    }

    if (event is SelectAsset) {
      yield* _mapSelectAssetToState(event);
    }
  }

  Stream<GalleryState> _mapFetchAssetsToState(
    GalleryEvent event,
  ) async* {
    List<AssetEntity> assetEntities = [];
    yield state.copyWith(status: GalleryStatus.fetching);

    debugPrint('************** Fetch album data');
    final albums = await PhotoManager.getAssetPathList(
      onlyAll: false,
      hasAll: true,
      filterOption: FilterOptionGroup(),
    );
    debugPrint('************** ${albums.length} Album(s) found');
    var albumsData = <AssetPathEntityData>[];

    for (AssetPathEntity album in albums) {
      if(album.name.toLowerCase() != "recent") {
        var entitiesAsset = <AssetEntityData>[];

        var assets = await album.getAssetListRange(
          start: 0, // start at index 0
          end: Constants.galleryPerPage, // get 50 items
        );

        for (var asset in assets) {
          var file = await asset.file;
          late int? size;
          if(file != null) {
            size = await file.length();
          }

          entitiesAsset.add(
            AssetEntityData(
              entity: asset,
              file: file,
              size: size,
            ),
          );
        }

        int imageCount = 0;
        int videosCount = 0;
        var assetsList = await album.assetList;
        for (var element in assetsList) {
          if(element.type == AssetType.image) imageCount++;
          if(element.type == AssetType.video) videosCount++;

          assetEntities.add(element);
        }

        if(galleryMode == GalleryMode.photo && imageCount > 0) {
          albumsData.add(
            AssetPathEntityData(
              entityPath: album,
              assets: entitiesAsset,
              videoCount: videosCount,
              imageCount: imageCount,
            ),
          );
        }

        if(galleryMode == GalleryMode.video && videosCount > 0) {
          albumsData.add(
            AssetPathEntityData(
              entityPath: album,
              assets: entitiesAsset,
              videoCount: videosCount,
              imageCount: imageCount,
            ),
          );
        }

        if(galleryMode == GalleryMode.mixed) {
          albumsData.add(
            AssetPathEntityData(
              entityPath: album,
              assets: entitiesAsset,
              videoCount: videosCount,
              imageCount: imageCount,
            ),
          );
        }
      }
    }

    yield state.copyWith(status: GalleryStatus.fetched, assets: albumsData, assetEntities: assetEntities,);
  }

  Stream<GalleryState> _mapSelectAssetToState(SelectAsset event,) async* {
    List<AssetEntity> selectedAssets = List.from(state.selectedAssets);
    var assetIndex = state.selectedAssets.indexWhere((item) => item.id == event.asset.id);

    if(assetIndex >= 0) {
      selectedAssets.removeAt(assetIndex);
    } else {
      selectedAssets.add(event.asset);
    }

    yield state.copyWith(
      status: state.status == GalleryStatus.fetched ? GalleryStatus.intermediate : GalleryStatus.fetched,
      selectedAssets: selectedAssets,
    );
  }
}
