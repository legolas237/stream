part of 'signup_bloc.dart';

@immutable
abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SendOtp extends SignUpEvent {
  const SendOtp({
    required this.phoneNumber,
  });

  final PhoneNumber phoneNumber;

  @override
  String toString() => 'SendOtp';

  @override
  List<Object?> get props => [phoneNumber];
}

class ChangeStep extends SignUpEvent {
  const ChangeStep({
    required this.step,
  });

  final int step;

  @override
  String toString() => 'ChangeStep';

  @override
  List<Object?> get props => [step];
}

class VerifyOtp extends SignUpEvent {
  const VerifyOtp({
    required this.otp,
  });

  final String otp;

  @override
  String toString() => 'VerifyOtp';

  @override
  List<Object?> get props => [otp];
}

class InputChange extends SignUpEvent {
  const InputChange({
    required this.attribute,
    required this.value,
  });

  final String attribute;
  final dynamic value;

  @override
  String toString() => 'InputChange';

  @override
  List<Object?> get props => [attribute, value,];
}

class ResetState extends SignUpEvent {
  @override
  String toString() => 'ResetState';
}

class MakeRegistration extends SignUpEvent {
  @override
  String toString() => 'MakeRegistration';
}
