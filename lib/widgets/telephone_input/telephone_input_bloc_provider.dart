import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stream/repository/user_repository.dart';
import 'package:stream/widgets/telephone_input/bloc/telephone_verify_bloc.dart';
import 'package:stream/widgets/telephone_input/telephone_input.dart';

// ignore: must_be_immutable
class TelephoneInputWidgetBlocProvider extends StatelessWidget {
  const TelephoneInputWidgetBlocProvider({
    Key? key,
    this.onChanged,
    this.controller,
    this.phoneNumber,
    this.allowValidation = false,
    this.readOnly = false,
  }) : super(key: key);

  final bool readOnly;
  final PhoneNumber? phoneNumber;
  final bool allowValidation;
  final TextEditingController? controller;
  final ValueChanged<PhoneNumber>? onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TelephoneVerifyBloc>(
      create: (context) => TelephoneVerifyBloc(
        repository: UserRepository(),
      ),
      child: TelephoneInputWidget(
        onChanged: onChanged,
        controller: controller,
        phoneNumber: phoneNumber,
        allowValidation: allowValidation,
        readOnly: readOnly,
      ),
    );
  }
}
