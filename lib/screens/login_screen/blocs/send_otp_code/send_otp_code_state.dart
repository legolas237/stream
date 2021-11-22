part of 'send_otp_code_bloc.dart';

enum SendingStatus { initial, sending, success, error }

@immutable
class SendOtpCodeState extends Equatable {
  const SendOtpCodeState({
    this.status = SendingStatus.initial,
  });

  final SendingStatus status;

  SendOtpCodeState copyWith({
    SendingStatus? status,
  }) {
    return SendOtpCodeState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
