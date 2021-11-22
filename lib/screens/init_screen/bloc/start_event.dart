part of 'start_bloc.dart';

@immutable
abstract class StartEvent extends Equatable {
  const StartEvent();

  @override
  List<Object> get props => [];
}

class StartReady extends StartEvent {
  @override
  String toString() => 'StartReady';
}
