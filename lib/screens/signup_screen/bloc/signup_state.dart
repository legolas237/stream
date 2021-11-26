part of 'signup_bloc.dart';

enum SignUpStatus { initial, processing, success, error }

@immutable
class SignUpState extends Equatable {
  const SignUpState({
    this.status = SignUpStatus.initial,
    this.message,
    this.step = 0,
    this.phoneNumber,
  });

  final SignUpStatus status;
  final String? message;
  final int step;
  final PhoneNumber? phoneNumber;


  SignUpState copyWith({
    SignUpStatus? status,
    String? message,
    int? step,
    PhoneNumber? phoneNumber,
  }) {
    return SignUpState(
      status: status ?? this.status,
      message: message ?? this.message,
      step: step ?? this.step,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object?> get props => [status, message, step];
}
