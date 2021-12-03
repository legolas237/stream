part of 'unlock_account_bloc.dart';

@immutable
abstract class UnlockAccountEvent extends Equatable {
  const UnlockAccountEvent();

  @override
  List<Object?> get props => [];
}

class UnlockAccount extends UnlockAccountEvent {
  const UnlockAccount({
    required this.phoneNumber,
    required this.password,
  });

  final String phoneNumber;
  final String password;

  @override
  String toString() => 'UnlockAccount';

  @override
  List<Object?> get props => [phoneNumber, password];
}
