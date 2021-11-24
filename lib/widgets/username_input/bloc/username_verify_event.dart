part of 'username_verify_bloc.dart';

@immutable
abstract class UsernameVerifyEvent extends Equatable {
  const UsernameVerifyEvent();

  @override
  List<Object?> get props => [];
}

class Verify extends UsernameVerifyEvent {
  const Verify({required this.username});

  final String username;

  @override
  String toString() => 'Verify';

  @override
  List<Object?> get props => [username];
}
