import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

import 'package:stream/blocs/auth/auth_bloc.dart';
import 'package:stream/config/config.dart';
import 'package:stream/models/remote/user.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/app_bar_action/app_bar_action.dart';
import 'package:stream/widgets/app_scaffold/app_scaffold.dart';
import 'package:stream/widgets/avatar/avatar_bloc_provider.dart';

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: Constants.verticalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.horizontalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AvatarBlocProvider(),
                  const SizedBox(height: 20.0),
                  Text(
                    widget.user.smallName(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle1!.merge(
                      const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    '@${FlutterLibphonenumber().formatNumberSync(widget.user.userDetail.telephone)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.caption!.merge(
                      const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Render

  Widget _screenTitle() {
    return ScaffoldWidget.buildTitle(
      context,
      widget.palette,
      AppLocalizations.of(context)!.yourAccount,
    );
  }
}