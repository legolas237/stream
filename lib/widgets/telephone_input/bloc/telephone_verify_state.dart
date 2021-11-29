part of 'telephone_verify_bloc.dart';

enum CheckStatus {
  initial,
  verifying,
  success,
  failure,
  existing,
}

@immutable
class TelephoneVerifyState extends Equatable {
  const TelephoneVerifyState({
    this.status = CheckStatus.initial,
  });

  final CheckStatus status;

  TelephoneVerifyState copyWith({
    CheckStatus? status,
  }) {
    return TelephoneVerifyState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
