import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stream/blocs/auth/auth_bloc.dart';
import 'package:stream/config/config.dart';
import 'package:stream/models/remote/user.dart';
import 'package:stream/screens/cropper_screen/cropper_screen.dart';
import 'package:stream/screens/gallery_screen/widgets/gallery_option_item.dart';
import 'package:stream/screens/gallery_screen/gallery_screen_bloc_provider.dart';
import 'package:stream/screens/use_camera_screen/use_camera_screen.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/avatar/bloc/upload_avatar_bloc.dart';
import 'package:stream/widgets/circular_sized_avatar/circular_sized_avatar.dart';
import 'package:stream/widgets/divider/divider.dart';
import 'package:stream/widgets/spinner/spinner.dart';

// ignore: must_be_immutable
class AvatarWidget extends StatefulWidget {
  AvatarWidget({Key? key}) : super(key: key);

  late Palette palette;

  late User user;

  @override
  State<StatefulWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  late File? avatar;

  @override
  void initState() {
    super.initState();

    _initValues();
  }

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.appTheme.palette;

    widget.user = BlocProvider.of<AuthBloc>(context, listen: true).state.user!;

    return BlocBuilder<UploadAvatarBloc, UploadAvatarState>(
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.18,
          width: MediaQuery.of(context).size.height * 0.18,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularSizedAvatarWidget(
                backgroundColor: widget.palette.borderColor(0.4),
                size: MediaQuery.of(context).size.height * 0.16,
                backgroundImage: NetworkImage(widget.user.profilePicture ?? ''),),
              if(state is! Uploading) Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 36,
                  height: 36,
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: widget.palette.borderColor(1),
                      width: 1,
                    ),
                    color: widget.palette.whiteColor(1),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: widget.palette.textColor(0.6),
                      size: 18,
                    ),
                    splashColor: widget.palette.splashLightColor(1.0),
                    highlightColor: widget.palette.highLightLightColor(1.0),
                    hoverColor: widget.palette.highLightLightColor(1.0),
                    onPressed: () {
                      _showPickerBottomSheet();
                    },
                  ),
                ),
              ),
              if(state is Uploading) Container(color: widget.palette.whiteColor(0.4)),
              if(state is Uploading) Container(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 20.0,
                  width: 20.0,
                  child: SpinnerWidget(
                    strokeWidth: 1.8,
                    colors: AlwaysStoppedAnimation<Color>(
                      widget.palette.secondaryBrandColor(1.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Render

  void _showPickerBottomSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: ThemeProvider.of(context)!.appTheme.palette.scaffoldColor(1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Constants.horizontalPadding,
                  vertical: 6.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.pickPhoto,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle2!.merge(const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.close,
                        style: Theme.of(context).textTheme.subtitle2!.merge(TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: widget.palette.secondaryBrandColor(1.0),
                        )),
                      ),
                    )
                  ],
                ),
              ),
              GalleryOptionItemWidget(
                onSelected: () {
                  _takePictureFromCamera();
                },
                icon: Icons.camera_alt,
                content: AppLocalizations.of(context)!.useCamera,
              ),
              DividerWidget(),
              GalleryOptionItemWidget(
                onSelected: () {
                  Navigator.pop(context);
                  _pickImage();
                },
                icon: Icons.landscape,
                content: AppLocalizations.of(context)!.selectFromGallery,
              ),
            ],
          ),
        );
      },
    );
  }

  // Callback

  void _initValues() {
    avatar = null;
  }

  void _takePictureFromCamera() async {
    Navigator.pop(context);

    File? result = await Navigator.push<File>(
      context,
      MaterialPageRoute(
        builder: (_) => UseCameraScreen(),
      ),
    );

    if (result != null) {
      _cropImage(result);
    }
  }

  Future<void> _cropImage(File image) async {
    File? result = await Navigator.push<File>(
      context,
      MaterialPageRoute(
        builder: (_) => CropperScreen(
          imageFile: image,
        ),
      ),
    );

    if (result != null) {
      BlocProvider.of<UploadAvatarBloc>(context).add(
          UploadAvatar(result),
      );
    }
  }

  void _pickImage() async {
    File? result = await Navigator.push<File>(
      context,
      MaterialPageRoute(
        builder: (_) => const GalleryScreenBlocProvider(),
      ),
    );

    if (result != null) {
      _cropImage(result);
    }
  }
}
