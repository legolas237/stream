part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object?> get props => [];
}

class LaunchCounter extends CounterEvent {
  const LaunchCounter({
    this.increment = false,
  });

  final bool increment;

  @override
  String toString() => 'LaunchCounter';

  @override
  List<Object?> get props => [false];
}

class ResetCounter extends CounterEvent {
  const ResetCounter({
    required this.start,
    required this.end,
  });

  final int start;
  final int end;

  @override
  String toString() => 'ResetCounter';

  @override
  List<Object?> get props => [start, end];
}