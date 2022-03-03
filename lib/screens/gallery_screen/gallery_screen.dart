import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:stream/config/config.dart';

import 'package:stream/screens/gallery_screen/bloc/gallery_bloc.dart';
import 'package:stream/screens/gallery_screen/widgets/asset_path_item.dart';
import 'package:stream/screens/gallery_screen/widgets/gallery_tab_item.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/annotation_region/annotation_region.dart';
import 'package:stream/widgets/app_bar_action/app_bar_action.dart';
import 'package:stream/widgets/border_wrapper/border_wrapper.dart';
import 'package:stream/widgets/error_wrapper/error_wrapper.dart';
import 'package:stream/widgets/spinner/spinner.dart';

enum DisplayMode {
  list, grid
}

enum GalleryMode {
  photo, video, mixed
}

enum SelectionMode {
  mono, multi
}

// ignore: must_be_immutable
class GalleryScreen extends StatefulWidget {
  static const routeName = '/gallery';

  GalleryScreen({
    Key? key,
    this.galleryMode = GalleryMode.photo,
    this.selectionMode = SelectionMode.mono,
  }) : super(key: key);

  late Palette palette;

  final GalleryMode? galleryMode;
  final SelectionMode? selectionMode;

  @override
  State<StatefulWidget> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late int galleryPermission;
  late GalleryMode galleryMode;
  late SelectionMode selectionMode;
  late DisplayMode displayMode;

  @override
  void initState() {
    super.initState();

    galleryMode = widget.galleryMode ?? GalleryMode.photo;
    selectionMode = widget.selectionMode ?? SelectionMode.mono;
    galleryPermission = -1;
    displayMode = DisplayMode.grid;
  }

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.appTheme.palette;

    // Request gallery permissions
    _requestPermission();

    return BlocConsumer<GalleryBloc, GalleryState>(
      listener: (context, state) {},
      builder: (context, state) {
        return AnnotationRegionWidget(
          brightness: Brightness.dark,
          color: widget.palette.annotationRegionColor(1.0),
          child: Scaffold(
            backgroundColor: widget.palette.scaffoldColor(1.0),
            appBar: AppBar(
              backgroundColor: widget.palette.scaffoldColor(1.0),
              automaticallyImplyLeading: false,
              centerTitle: false,
              title: _buildAppBarTitle(state),
              actions: [
                if(state.selectedAssets.isEmpty && galleryMode != GalleryMode.mixed && (state.status == GalleryStatus.fetched || state.status == GalleryStatus.intermediate)) Row(
                  children: [
                    GalleryTabItemWidget(
                      text: AppLocalizations.of(context)!.photo,
                      isSelected: galleryMode == GalleryMode.photo,
                    ),
                    GalleryTabItemWidget(
                      text: AppLocalizations.of(context)!.videos,
                      isSelected: galleryMode == GalleryMode.video,
                    ),
                  ],
                ),
                const SizedBox(width: 8.0),
                if(state.selectedAssets.isNotEmpty) AppBarActionWidget(
                  splashColor: widget.palette.splashLightColor(1.0),
                  highLightColor: widget.palette.highLightLightColor(1.0),
                  icon: Icon(
                    Icons.check_outlined,
                    color: widget.palette.textColor(1.0),
                    size: 22,
                  ),
                  onPressed: () async {
                    List<File?> files = [];

                    for (var element in state.selectedAssets) {
                      var file = await element.file;
                      files.add(file);
                    }

                    Navigator.pop<List<File?>>(context, files);
                  },
                ),
                if(state.status == GalleryStatus.fetching) Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(width: 14.0),
                    SizedBox(
                      height: 16.0,
                      width: 16.0,
                      child: SpinnerWidget(
                        strokeWidth: 1.8,
                        colors: AlwaysStoppedAnimation<Color>(
                          widget.palette.secondaryBrandColor(1.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14.0),
                  ],
                ),
              ],
              leading: AppBarActionWidget(
                splashColor: widget.palette.splashLightColor(1.0),
                highLightColor: widget.palette.highLightLightColor(1.0),
                icon: Icon(
                  Icons.close_outlined,
                  color: widget.palette.textColor(1.0),
                  size: 22,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: BorderlessWrapperWidget(
              top: true,
              bottom: false,
              child: _buildTree(state),
            ),
          ),
        );
      },
    );
  }

  // Renders

  Widget _buildTree(GalleryState state) {
    if (state.status == GalleryStatus.initial) {
      BlocProvider.of<GalleryBloc>(context).add(
        FetchAssets(),
      );
    }

    if (galleryPermission == 0) {
      return _buildNoCameraPermission();
    }

    if (state.status == GalleryStatus.fetched || state.status == GalleryStatus.intermediate) {
      return CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: Constants.horizontalPadding,
                top: 6.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.displayIn,
                      style: Theme.of(context).textTheme.caption!.merge(
                        const TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      AppBarActionWidget(
                        splashColor: widget.palette.splashLightColor(1.0),
                        highLightColor: widget.palette.highLightLightColor(1.0),
                        icon: Icon(
                          Icons.grid_view,
                          color: displayMode == DisplayMode.grid ? widget.palette.textColor(1.0) : widget.palette.captionColor(1.0),
                          size: 18.0,
                        ),
                        onPressed: () {
                          setState(() {
                            displayMode = DisplayMode.grid;
                          });
                        },
                      ),
                      AppBarActionWidget(
                        splashColor: widget.palette.splashLightColor(1.0),
                        highLightColor: widget.palette.highLightLightColor(1.0),
                        icon: Icon(
                          Icons.format_list_bulleted,
                          color: displayMode == DisplayMode.list ? widget.palette.textColor(1.0) : widget.palette.captionColor(1.0),
                          size: 18.0,
                        ),
                        onPressed: () {
                          setState(() {
                            displayMode = DisplayMode.list;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20.0),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              var asset = state.assets[index];

              return AssetPathItemWidget(
                data: asset,
                onSelect: _selectImage,
                displayMode: displayMode,
              );
              },
              childCount: state.assets.length,
            ),
          ),
        ],
      );
    }

    return Container();
  }

  Widget _buildNoCameraPermission() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.16,
          ),
          child: ErrorWrapperWidget(
            assetImage: 'assets/images/gallery_illustration.png',
            title: AppLocalizations.of(context)!.gallery,
            subTitle: AppLocalizations.of(context)!.galleryPermission,
            callback: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildAppBarTitle(GalleryState state) {
    if(state.selectedAssets.isNotEmpty) {
      return Text(
        AppLocalizations.of(context)!.selectCount(
          state.selectedAssets.length,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.subtitle1!.merge(
          const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Text(
      AppLocalizations.of(context)!.gallery,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.subtitle1!.merge(
        const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Callback

  void _requestPermission() async {
    if (galleryPermission == -1) {
      final permitted = await PhotoManager.requestPermissionExtend();

      setState(() {
        galleryPermission = permitted.isAuth ? 1 : 0;
      });
    }
  }

  void _selectImage(AssetEntity asset) async {
    File? file = await asset.file;

    if(selectionMode == SelectionMode.multi) {
      BlocProvider.of<GalleryBloc>(context).add(
        SelectAsset(asset: asset),
      );
    } else {
      Navigator.pop<List<File?>>(context, [file]);
    }
  }
}
