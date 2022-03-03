import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stream/screens/gallery_screen/bloc/gallery_bloc.dart';
import 'package:stream/screens/gallery_screen/gallery_screen.dart';

class GalleryScreenBlocProvider extends StatelessWidget {
  const GalleryScreenBlocProvider({
    Key? key,
    this.galleryMode = GalleryMode.photo,
    this.selectionMode = SelectionMode.mono,
  }) : super(key: key);

  final GalleryMode? galleryMode;
  final SelectionMode? selectionMode;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GalleryBloc>(
      create: (BuildContext context) {
        return GalleryBloc(
          galleryMode: galleryMode,
        );
      },
      child: GalleryScreen(
        galleryMode: galleryMode,
        selectionMode: selectionMode,
      ),
    );
  }
}