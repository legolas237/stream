import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter/foundation.dart';

import 'package:stream/config/config.dart';
import 'package:stream/models/util/asset_path_entity_data.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc() : super(GalleryState());

  @override
  Stream<GalleryState> mapEventToState(GalleryEvent event) async* {
    if (event is FetchAssets) {
      yield* _mapFetchAssetsToState(event);
    }
  }

  Stream<GalleryState> _mapFetchAssetsToState(
    GalleryEvent event,
  ) async* {
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
        var assets = await album.getAssetListRange(
          start: 0, // start at index 0
          end: Constants.galleryPerPage, // get 50 items
        );

        albumsData.add(
          AssetPathEntityData(
            entityPath: album,
            assets: assets,
          ),
        );
      }
    }

    yield state.copyWith(status: GalleryStatus.fetched, assets: albumsData);
  }
}
