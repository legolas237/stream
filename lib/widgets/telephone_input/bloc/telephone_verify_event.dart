part of 'telephone_verify_bloc.dart';

@immutable
abstract class TelephoneVerifyEvent extends Equatable {
  const TelephoneVerifyEvent();

  @override
  List<Object?> get props => [];
}

class Verify extends TelephoneVerifyEvent {
  const Verify({required this.telephone});

  final String telephone;

  @override
  String toString() => 'Verify';

  @override
  List<Object?> get props => [telephone];
}

class Reset extends TelephoneVerifyEvent {
  @override
  String toString() => 'Reset';
}
