import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stream/blocs/auth/auth_bloc.dart';
import 'package:stream/repository/user_repository.dart';
import 'package:stream/screens/unlock_screen/bloc/unlock_account_bloc.dart';
import 'package:stream/screens/unlock_screen/unlock_screen.dart';

// ignore: must_be_immutable
class UnlockScreenBlocProvider extends StatelessWidget {
  const UnlockScreenBlocProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UnlockAccountBloc>(
      create: (BuildContext context) {
        return UnlockAccountBloc(
          userRepository: UserRepository(),
          authBloc: BlocProvider.of<AuthBloc>(context),
        );
      },
      child: UnlockScreen(),
    );
  }
}
