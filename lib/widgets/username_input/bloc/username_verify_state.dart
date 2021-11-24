part of 'username_verify_bloc.dart';

enum CheckStatus {
  initial,
  verifying,
  success,
  failure,
  existing,
}

@immutable
class UsernameVerifyState extends Equatable {
  const UsernameVerifyState({
    this.status = CheckStatus.initial,
  });

  final CheckStatus status;

  UsernameVerifyState copyWith({
    CheckStatus? status,
  }) {
    return UsernameVerifyState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
