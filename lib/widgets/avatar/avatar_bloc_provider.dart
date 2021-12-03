import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stream/blocs/auth/auth_bloc.dart';
import 'package:stream/repository/user_repository.dart';
import 'package:stream/widgets/avatar/avatar.dart';
import 'package:stream/widgets/avatar/bloc/upload_avatar_bloc.dart';

// ignore: must_be_immutable
class AvatarBlocProvider extends StatelessWidget {
  const AvatarBlocProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UploadAvatarBloc>(
      create: (BuildContext context) {
        return UploadAvatarBloc(
          userRepository: UserRepository(),
          authBloc: BlocProvider.of<AuthBloc>(context),
        );
      },
      child: AvatarWidget(),
    );
  }
}
