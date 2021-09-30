part of 'auth_bloc.dart';

enum AuthStatus {
  ready,
  authenticated,
  unauthenticated,
  unknown,
  userChange,
}

@immutable
class AuthState extends Equatable{
  const AuthState._({
    this.status = AuthStatus.unknown,
    this.user,
  });

  final AuthStatus status;
  final User? user;

  @override
  List<Object?> get props => [status, user];

  const AuthState.unknown() : this._();

  const AuthState.ready([User? user])
      : this._(status: AuthStatus.ready, user: user,);

  const AuthState.userChange(User? user)
      : this._(status: user == null ? AuthStatus.unauthenticated : AuthStatus.authenticated, user: user,);

  const AuthState.authenticated(User user)
      : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  @override
  String toString() => 'AuthState {status: $status}';
}
