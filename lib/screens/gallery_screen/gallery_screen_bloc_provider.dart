import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stream/screens/gallery_screen/bloc/gallery_bloc.dart';
import 'package:stream/screens/gallery_screen/gallery_screen.dart';

class GalleryScreenBlocProvider extends StatelessWidget {
  const GalleryScreenBlocProvider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GalleryBloc>(
      create: (BuildContext context) {
        return GalleryBloc();
      },
      child: GalleryScreen(),
    );
  }
}