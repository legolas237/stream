import 'package:basic_utils/basic_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:stream/blocs/auth/auth_bloc.dart';
import 'package:stream/repository/phone_code_repository.dart';
import 'package:stream/repository/storage_repository.dart';
import 'package:stream/repository/user_repository.dart';
import 'package:stream/widgets/telephone_input/telephone_input.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required this.phoneCodeRepository,
    required this.userRepository,
    required this.authBloc,
  }) : super(SignUpState());

  final PhoneCodeRepository phoneCodeRepository;
  final UserRepository userRepository;
  final AuthBloc authBloc;

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

    if (event is ResetState) {
      yield* _mapResetToState(event);
    }
  }

  Stream<SignUpState> _mapResetToState(ResetState event,) async* {
    yield state.copyWith(status: SignUpStatus.initial,);
  }

  Stream<SignUpState> _mapRegistrationToState(MakeRegistration event,) async* {
    yield state.copyWith(status: SignUpStatus.processing,);

    try {
      var data = Map<String, String>.from(state.registrationData);
      data['telephone'] = state.phoneNumber!.phoneNumber;

      var apiResponse = await userRepository.registration(data);

      if(apiResponse != null){
        switch(apiResponse.code) {
          case 100: // Okay
            // Get token and store it
            var token = apiResponse.data['plainTextToken'];
            var abilities = apiResponse.data['accessToken']['abilities'] as List;

            // Get auth user infos
            apiResponse = await userRepository.authUser(token);

            if(apiResponse != null && apiResponse.code == 100){
              // Get Auth user and store it
              var user = apiResponse.deserializeUser();

              if(user != null) {
                await StorageRepository.setToken(token);
                user.abilities = abilities;
                await StorageRepository.setUser(user);

                // Notify auth bloc
                authBloc.add(
                  AuthStatusChanged(
                    status: AuthStatus.authenticated,
                    user: user,
                  ),
                );

                yield state.copyWith(
                  status: SignUpStatus.recorded,
                );
                return;
              }
            }

            yield state.copyWith(status: SignUpStatus.error);
            break;
          case 150: // Validation error
            yield state.copyWith(
              status: SignUpStatus.error,
              messages: apiResponse.data as Map<String, dynamic>,
            );
            break;
          default: // Error, Unable to verify telephone
            yield state.copyWith(
              status: SignUpStatus.error,
              messages: apiResponse.message,
            );
            break;
        }
      } else {
        yield state.copyWith(status: SignUpStatus.error);
      }
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
              messages: messages.first.toString(),
            );
            break;
          default: // Error
            yield state.copyWith(
              status: SignUpStatus.error,
              messages: apiResponse.message,
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
              messages: messages.first.toString(),
            );
            break;
          default: // Error
            yield state.copyWith(
              status: SignUpStatus.error,
              messages: apiResponse.message,
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
      status: _validateInputs(data) ? SignUpStatus.readyToRegister : SignUpStatus.intermediate,
      registrationData: data,
    );
  }

  // Others

  bool _validateInputs(Map<String, String> data) {
    var checkPassword = data.keys.contains('password') &&  StringUtils.isNotNullOrEmpty(data['password']);
    var checkName = data.keys.contains('name') &&  StringUtils.isNotNullOrEmpty(data['name']);
    var checkDateOfBirth = data.keys.contains('data_of_birth') &&  StringUtils.isNotNullOrEmpty(data['data_of_birth']);

    return checkPassword && checkName && checkDateOfBirth;
  }
}
