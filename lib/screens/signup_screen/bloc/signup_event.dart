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
