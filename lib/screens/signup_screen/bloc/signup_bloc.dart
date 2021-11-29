import 'package:basic_utils/basic_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:stream/repository/phone_code_repository.dart';
import 'package:stream/repository/user_repository.dart';
import 'package:stream/widgets/telephone_input/telephone_input.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required this.phoneCodeRepository,
    required this.userRepository,
  }) : super(SignUpState());

  final PhoneCodeRepository phoneCodeRepository;
  final UserRepository userRepository;

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SendOtp) {
      yield* _mapSendOtpCodeToState(event);
    }

    if (event is ChangeStep) {
      yield* _mapChangeStepToState(event);
    }

    if (event is VerifyOtp) {
      yield* _mapVerifyOtpToState(event);
    }

    if (event is InputChange) {
      yield* _mapInputChangeToState(event);
    }

    if (event is MakeRegistration) {
      yield* _mapRegistrationToState(event);
    }
  }

  Stream<SignUpState> _mapRegistrationToState(MakeRegistration event,) async* {
    yield state.copyWith(status: SignUpStatus.processing,);

    try {
      var data = Map<String, String>.from(state.registrationData);
      data['telephone'] = state.phoneNumber!.phoneNumber;

      final apiResponse = await userRepository.registration(data);

      if(apiResponse != null){
        switch(apiResponse.code) {
          case 100: // Okay
            yield state.copyWith(
              status: SignUpStatus.recorded,
              step: 3,
            );
            break;
          case 150: // Validation error
            var messages = (apiResponse.data as Map).values.map((item) => item.toString());

            yield state.copyWith(
              status: SignUpStatus.error,
              message: messages.first.toString(),
            );
            break;
          default: // Error, Unable to verify telephone
            yield state.copyWith(
              status: SignUpStatus.error,
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
              status: SignUpStatus.otpSent,
              step: 1,
            );
            break;
          case 150: // Validation error
            var messages = (apiResponse.data as Map).values.map((item) => item.toString());

            yield state.copyWith(
              status: SignUpStatus.error,
              message: messages.first.toString(),
            );
            break;
          default: // Error
            yield state.copyWith(
              status: SignUpStatus.error,
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

  Stream<SignUpState> _mapVerifyOtpToState(VerifyOtp event) async* {
    yield state.copyWith(status: SignUpStatus.processing,);

    try {
      final apiResponse = await phoneCodeRepository.verify(
        event.otp,
        state.phoneNumber!.phoneNumber,
      );

      if(apiResponse != null){
        switch(apiResponse.code) {
          case 100: // Okay
            yield state.copyWith(
              status: SignUpStatus.otpVerify,
              step: 2,
            );
            break;
          case 150: // Validation error
            var messages = (apiResponse.data as Map).values.map((item) => item.toString());

            yield state.copyWith(
              status: SignUpStatus.error,
              message: messages.first.toString(),
            );
            break;
          default: // Error
            yield state.copyWith(
              status: SignUpStatus.error,
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

  Stream<SignUpState> _mapInputChangeToState(InputChange event) async* {
    var data = Map<String, String>.from(state.registrationData);
    data[event.attribute] = event.value;
    
    yield state.copyWith(
      status: _validateInputs() ? SignUpStatus.readyToRegister : (state.status == SignUpStatus.intermediate ? SignUpStatus.initial : SignUpStatus.intermediate),
      registrationData: data,
    );
  }

  // Others

  bool _validateInputs() {
    var checkUsername = state.registrationData.keys.contains('username') &&  StringUtils.isNotNullOrEmpty(state.registrationData['username']);
    var checkPassword = state.registrationData.keys.contains('password') &&  StringUtils.isNotNullOrEmpty(state.registrationData['password']);
    var checkLastName = state.registrationData.keys.contains('last_name') &&  StringUtils.isNotNullOrEmpty(state.registrationData['last_name']);
    var checkFirstName = state.registrationData.keys.contains('first_name') &&  StringUtils.isNotNullOrEmpty(state.registrationData['first_name']);
    var checkDateOfBirth = state.registrationData.keys.contains('data_of_birth') &&  StringUtils.isNotNullOrEmpty(state.registrationData['data_of_birth']);

    return checkUsername && checkPassword && checkLastName && checkFirstName && checkDateOfBirth;
  }
}
