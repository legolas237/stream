part of 'send_otp_code_bloc.dart';

@immutable
abstract class SendOtpCodeEvent extends Equatable {
  const SendOtpCodeEvent();

  @override
  List<Object?> get props => [];
}

class SendOtpCode extends SendOtpCodeEvent {
  const SendOtpCode({required this.telephone,});

  final String telephone;

  @override
  List<Object?> get props => [telephone];

  @override
  String toString() => 'SendOtpCode {telephone: $telephone}';
}