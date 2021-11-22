import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'send_otp_code_event.dart';
part 'send_otp_code_state.dart';

class SendOtpCodeBloc extends Bloc<SendOtpCodeEvent, SendOtpCodeState> {
  SendOtpCodeBloc() : super(const SendOtpCodeState());

  @override
  Stream<SendOtpCodeState> mapEventToState(SendOtpCodeEvent event,) async* {
    if (event is SendOtpCode) {
      yield* _fakeToState(event);
    }
  }

  Stream<SendOtpCodeState> _fakeToState(SendOtpCodeEvent event,) async* {
    yield state.copyWith(status: state.status == SendingStatus.success ? SendingStatus.initial : SendingStatus.success,);
  }
}
