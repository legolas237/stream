part of 'unlock_account_bloc.dart';

enum UnlockStatus {
  initial,
  processing,
  unlocked,
  error,
}

@immutable
// ignore: must_be_immutable
class UnlockAccountState extends Equatable {
  const UnlockAccountState({
    this.status = UnlockStatus.initial,
    this.user,
    this.messages,
  });

  final UnlockStatus status;
  final User? user;
  final dynamic messages;

  UnlockAccountState copyWith({
    UnlockStatus? status,
    dynamic messages,
    User? user,
  }) {
    return UnlockAccountState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, messages, user];
}
