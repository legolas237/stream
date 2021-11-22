part of 'start_bloc.dart';

@immutable
abstract class StartState extends Equatable {
  const StartState();

  @override
  List<Object?> get props => [];
}

class StartInitial extends StartState {
  @override
  String toString() => 'StartInitial';
}

class StartApp extends StartState {
  @override
  String toString() => 'StartApp';
}