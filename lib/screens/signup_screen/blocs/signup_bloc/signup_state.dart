part of 'signup_bloc.dart';

enum SignUpStatus { initial, sending, success, error }

@immutable
class SignUpState extends Equatable {
  const SignUpState({
    this.status = SignUpStatus.initial,
  });

  final SignUpStatus status;

  SignUpState copyWith({
    SignUpStatus? status,
  }) {
    return SignUpState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
