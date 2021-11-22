import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'start_event.dart';
part 'start_state.dart';

class StartBloc extends Bloc<StartEvent, StartState> {
  StartBloc() : super(StartInitial());

  @override
  Stream<StartState> mapEventToState(StartEvent event) async* {
    if (event is StartReady) {
      yield* _mapReadyToState(event);
    }
  }

  Stream<StartState> _mapReadyToState(StartReady event) async* {
    // Wait 10 seconds
    await Future.delayed(const Duration(seconds: 10));

    yield StartApp();
  }
}
