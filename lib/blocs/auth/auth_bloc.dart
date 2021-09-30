import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:stream/models/remote/user.dart';
import 'package:stream/repository/storage_repository.dart';
import 'package:stream/repository/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const AuthState.unknown());

  final UserRepository _userRepository;

  @override
  Stream<AuthState> mapEventToState(AuthEvent event,) async* {
    if (event is AuthStatusChanged) {
      yield await _mapAuthStatusChangedToState(event);
    }
  }

  Future<AuthState> _mapAuthStatusChangedToState(AuthStatusChanged event,) async {
    switch (event.status) {
      case AuthStatus.userChange:
        if(event.user != null){
          await StorageRepository.setUser(event.user!);
        }
        return AuthState.userChange(event.user);
      case AuthStatus.ready:
        return const AuthState.ready();
      case AuthStatus.unauthenticated:
        await StorageRepository.clearAll();
        return const AuthState.unauthenticated();
      case AuthStatus.authenticated:
        await StorageRepository.setUser(event.user!);
        return AuthState.authenticated(event.user!);
      default:
        final user = _tryGetAuthUser();
        if (user != null) {
          return AuthState.ready(user);
        }

        return const AuthState.unauthenticated();
    }
  }

  // Utilities

  User? _tryGetAuthUser() {
    try {
      return _userRepository.getAuthUser();
    } on Exception {
      return null;
    }
  }
}
