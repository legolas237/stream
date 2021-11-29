import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stream/blocs/counter/counter_bloc.dart';
import 'package:stream/repository/phone_code_repository.dart';
import 'package:stream/repository/user_repository.dart';
import 'package:stream/screens/signup_screen/bloc/signup_bloc.dart';
import 'package:stream/screens/signup_screen/signup_screen.dart';

// ignore: must_be_immutable
class SignupScreenBlocProvider extends StatelessWidget {
  static const routeName = '/signup';

  const SignupScreenBlocProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpBloc>(
          create: (BuildContext context) {
            return SignUpBloc(
              phoneCodeRepository: PhoneCodeRepository(),
              userRepository: UserRepository(),
            );
          },
        ),
        BlocProvider<CounterBloc>(
          create: (BuildContext context) {
            return CounterBloc(
              start: 15,
              end: 1,
            );
          },
        ),
      ],
      child: SignupScreen(),
    );
  }
}
