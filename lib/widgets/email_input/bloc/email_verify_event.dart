part of 'email_verify_bloc.dart';

@immutable
abstract class EmailVerifyEvent extends Equatable {
  const EmailVerifyEvent();

  @override
  List<Object?> get props => [];
}

class Verify extends EmailVerifyEvent {
  const Verify({required this.email});

  final String email;

  @override
  String toString() => 'Verify';

  @override
  List<Object?> get props => [email];
}
