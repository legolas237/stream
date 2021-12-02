part of 'signup_bloc.dart';

enum SignUpStatus {
  initial,
  processing,
  otpSent,
  otpVerify,
  readyToRegister,
  recorded,
  error,
  intermediate,
}

@immutable
// ignore: must_be_immutable
class SignUpState extends Equatable {
  SignUpState({
    this.status = SignUpStatus.initial,
    this.step = 0,
    this.phoneNumber,
    this.registrationData = const {},
    this.messages = const {},
  });

  final SignUpStatus status;
  final dynamic messages;
  final int step;
  final PhoneNumber? phoneNumber;
  Map<String, String> registrationData;

  SignUpState copyWith({
    SignUpStatus? status,
    dynamic messages,
    int? step,
    PhoneNumber? phoneNumber,
    Map<String, String>? registrationData,
  }) {
    return SignUpState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      step: step ?? this.step,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      registrationData: registrationData ?? this.registrationData,
    );
  }

  @override
  List<Object?> get props => [status, messages, step, phoneNumber, registrationData];
}
