import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stream/repository/phone_code_repository.dart';
import 'package:stream/screens/signup_screen/bloc/signup_bloc.dart';
import 'package:stream/screens/signup_screen/signup_screen.dart';

// ignore: must_be_immutable
class SignupScreenBlocProvider extends StatelessWidget {
  static const routeName = '/signup';

  const SignupScreenBlocProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(
          phoneCodeRepository: PhoneCodeRepository(),
      ),
      child: SignupScreen(),
    );
  }
}
