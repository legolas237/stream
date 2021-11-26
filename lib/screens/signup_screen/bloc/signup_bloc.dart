import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:stream/repository/phone_code_repository.dart';
import 'package:stream/widgets/telephone_input/telephone_input.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required this.phoneCodeRepository,
  }) : super(const SignUpState());

  final PhoneCodeRepository phoneCodeRepository;

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SendOtp) {
      yield* _mapSendOtpCodeToState(event);
    }

    if (event is ChangeStep) {
      yield* _mapChangeStepToState(event);
    }
  }

  Stream<SignUpState> _mapSendOtpCodeToState(SendOtp event) async* {
    yield state.copyWith(
      status: SignUpStatus.processing,
      phoneNumber: event.phoneNumber,
    );

    try {
      final apiResponse = await phoneCodeRepository.send(
        event.phoneNumber.country!.alphaCode,
        event.phoneNumber.phoneNumber,
      );

      if(apiResponse != null){
        switch(apiResponse.code) {
          case 100: // Okay
            yield state.copyWith(
              status: SignUpStatus.success,
              step: 1,
            );
            break;
          case 150: // Validation error
            var messages = (apiResponse.data as Map).values.map((item) => item.toString());

            yield state.copyWith(
              status: SignUpStatus.success,
              message: messages.first.toString(),
            );
            break;
          default: // Error
            yield state.copyWith(
              status: SignUpStatus.success,
              message: apiResponse.message,
            );
            break;
        }
        return;
      }

      yield state.copyWith(status: SignUpStatus.error);
    } catch (error) {
      yield state.copyWith(status: SignUpStatus.error);
    }
  }

  Stream<SignUpState> _mapChangeStepToState(ChangeStep event) async* {
    yield state.copyWith(
      status: SignUpStatus.initial,
      step: event.step,
    );
  }
}
