part of 'counter_bloc.dart';

enum CounterStatus { initial, counting, ended }

@immutable
class CounterState extends Equatable {
  const CounterState({
    this.status = CounterStatus.initial,
    required this.start,
    required this.end,
  });

  final CounterStatus status;
  final int start;
  final int end;

  CounterState copyWith({
    CounterStatus? status,
    int? start,
    int? end,
  }) {
    return CounterState(
      status: status ?? this.status,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  @override
  List<Object?> get props => [status, start, end];
}
