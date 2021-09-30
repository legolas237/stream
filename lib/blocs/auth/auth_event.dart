part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStatusChanged extends AuthEvent {
  const AuthStatusChanged({
    required this.status,
    this.user,
  });

  final AuthStatus status;
  final User? user;

  @override
  List<Object?> get props => [status, user];
}
