import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stream/repository/user_repository.dart';
import 'package:stream/widgets/email_input/bloc/email_verify_bloc.dart';
import 'package:stream/widgets/email_input/email_input.dart';

// ignore: must_be_immutable
class EmailInputWidgetBlocProvider extends StatelessWidget {
  const EmailInputWidgetBlocProvider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmailVerifyBloc>(
      create: (context) => EmailVerifyBloc(
        repository: UserRepository(),
      ),
      child: EmailInputWidget(),
    );
  }

}