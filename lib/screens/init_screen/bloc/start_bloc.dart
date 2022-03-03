import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:stream/blocs/auth/auth_bloc.dart';
import 'package:stream/models/remote/user.dart';
import 'package:stream/task/sync_task.dart';

part 'start_event.dart';

part 'start_state.dart';

class StartBloc extends Bloc<StartEvent, StartState> {
  StartBloc({
    required this.authBloc,
  }) : super(StartInitial());

  final AuthBloc authBloc;

  @override
  Stream<StartState> mapEventToState(StartEvent event) async* {
    if (event is StartReady) {
      yield* _mapReadyToState(event);
    }
  }

  Stream<StartState> _mapReadyToState(StartReady event) async* {
    // Wait 10 seconds
    await Future.delayed(const Duration(seconds: 6));

    if (authBloc.state.status == AuthStatus.authenticated || authBloc.state.status == AuthStatus.ready) {
      User? user = await SyncWork.instance.fetchUserData();
      if (user != null) {
        authBloc.add(
          AuthStatusChanged(
            status: AuthStatus.userChange,
            user: user,
          ),
        );
      }

      yield StartApp();
      return;
    }

    yield StartLogin();
  }
}
