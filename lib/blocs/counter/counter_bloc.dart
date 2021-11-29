import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc({
    required int start,
    required int end,
  }) : super(CounterState(start: start, end: end));

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is LaunchCounter) {
      yield* _mapLaunchToState(event);
    }

    if (event is ResetCounter) {
      yield* _mapResetToState(event);
    }
  }

  Stream<CounterState> _mapLaunchToState(LaunchCounter event) async* {
    if(state.start == state.end) {
      yield state.copyWith(status: CounterStatus.ended,);
      return;
    }

    await Future.delayed(const Duration(seconds: 1));
    yield state.copyWith(
      status: CounterStatus.counting,
      start: event.increment ? state.start + 1 : state.start - 1,
    );

    yield* _mapLaunchToState(event);
  }

  Stream<CounterState> _mapResetToState(ResetCounter event) async* {
    yield state.copyWith(
      status: CounterStatus.initial,
      start: event.start,
      end: event.end,
    );
  }
}
