part of 'email_verify_bloc.dart';

enum CheckStatus {
  initial,
  verifying,
  success,
  failure,
  existing,
}

@immutable
class EmailVerifyState extends Equatable {
  const EmailVerifyState({
    this.status = CheckStatus.initial,
  });

  final CheckStatus status;

  EmailVerifyState copyWith({
    CheckStatus? status,
  }) {
    return EmailVerifyState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
