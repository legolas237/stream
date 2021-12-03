import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:photo_manager/photo_manager.dart';

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

enum GalleryMode {
  photo, video
}

// ignore: must_be_immutable
class GalleryScreen extends StatefulWidget {
  static const routeName = '/gallery';

  GalleryScreen({
    Key? key,
  }) : super(key: key);

  late Palette palette;

  @override
  State<StatefulWidget> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late int galleryPermission;
  late GalleryMode galleryMode = GalleryMode.photo;

  @override
  void initState() {
    super.initState();

    galleryPermission = -1;
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
              centerTitle: true,
              title: _buildAppBarTitle(),
              actions: [
                if(state.status == GalleryStatus.fetched) Row(
                  children: [
                    GalleryTabItemWidget(
                      icon: Icons.photo,
                      isSelected: galleryMode == GalleryMode.photo,
                      onSelected: () {
                        setState(() {
                          galleryMode = GalleryMode.photo;
                        });
                      },
                    ),
                    GalleryTabItemWidget(
                      icon: Icons.videocam,
                      isSelected: galleryMode == GalleryMode.video,
                      onSelected: () {
                        setState(() {
                          galleryMode = GalleryMode.video;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(width: 10.0),
                state.status == GalleryStatus.fetching
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: 14.0),
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
                      )
                    : const SizedBox(),
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

    if (state.status == GalleryStatus.fetched) {
      return CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(height: 20.0),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return AssetPathItemWidget(
                  data: state.assets[index],
                  onSelect: _selectImage,
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

  Widget _buildAppBarTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            AppLocalizations.of(context)!.gallery,
            style: Theme.of(context).textTheme.subtitle1!.merge(
              const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

      ],
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

    Navigator.pop<File>(context, file);
  }
}
