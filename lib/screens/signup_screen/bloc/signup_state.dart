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
    this.message,
    this.step = 0,
    this.phoneNumber,
    this.registrationData = const {},
  });

  final SignUpStatus status;
  final String? message;
  final int step;
  final PhoneNumber? phoneNumber;
  Map<String, String> registrationData;

  SignUpState copyWith({
    SignUpStatus? status,
    String? message,
    int? step,
    PhoneNumber? phoneNumber,
    Map<String, String>? registrationData,
  }) {
    return SignUpState(
      status: status ?? this.status,
      message: message ?? this.message,
      step: step ?? this.step,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      registrationData: registrationData ?? this.registrationData,
    );
  }

  @override
  List<Object?> get props => [status, message, step, phoneNumber, registrationData];
}
