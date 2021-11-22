import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stream/screens/init_screen/bloc/start_bloc.dart';
import 'package:stream/screens/init_screen/init_screen.dart';

class InitScreenBlocProvider extends StatelessWidget {
  const InitScreenBlocProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StartBloc(),
      child: InitScreen(),
    );
  }
}
