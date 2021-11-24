import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stream/repository/user_repository.dart';
import 'package:stream/widgets/Username_input/Username_input.dart';
import 'package:stream/widgets/username_input/bloc/username_verify_bloc.dart';

// ignore: must_be_immutable
class UsernameInputWidgetBlocProvider extends StatelessWidget {
  const UsernameInputWidgetBlocProvider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsernameVerifyBloc>(
      create: (context) => UsernameVerifyBloc(
        repository: UserRepository(),
      ),
      child: UserNameInputWidget(),
    );
  }

}