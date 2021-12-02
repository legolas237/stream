import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stream/blocs/auth/auth_bloc.dart';
import 'package:stream/config/config.dart';
import 'package:stream/models/remote/user.dart';
import 'package:stream/screens/auth_screen/auth_screen.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/app_bar_action/app_bar_action.dart';
import 'package:stream/widgets/app_scaffold/app_scaffold.dart';
import 'package:stream/widgets/border_wrapper/border_wrapper.dart';
import 'package:stream/widgets/circular_sized_avatar/circular_sized_avatar.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  late Palette palette;

  late User user;

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.appTheme.palette;

    widget.user = BlocProvider.of<AuthBloc>(context).state.user!;

    return ScaffoldWidget(
      appBarBackgroundColor: widget.palette.scaffoldColor(1.0),
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: _screenTitle(),
      actions: [
        Row(
          children: [
            AppBarActionWidget(
              onPressed: () {},
              splashColor: widget.palette.secondaryBrandColor(0.2),
              highLightColor: widget.palette.secondaryHighLightColor(0.2),
              icon: Icon(
                Icons.drive_file_rename_outline,
                size: 20.0,
                color: widget.palette.secondaryBrandColor(1.0),
              ),
            ),
            const SizedBox(width: 4.0),
          ],
        ),
      ],
      body: BorderlessWrapperWidget(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: Constants.verticalPadding,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Constants.horizontalPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircularSizedAvatarWidget(
                        backgroundColor: widget.palette.borderColor(0.4),
                        size: MediaQuery.of(context).size.height * 0.18,
                        backgroundImage: NetworkImage(widget.user.avatar ?? '')
                    ),
                    const SizedBox(width: 20.0),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        AppLocalizations.of(context)!.setPhoto,
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle1!.merge(
                          TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: widget.palette.secondaryBrandColor(1.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Render

  Widget _screenTitle() {
    return ScaffoldWidget.buildTitle(
      context,
      widget.palette,
      widget.user.smallName(),
    );
  }
}