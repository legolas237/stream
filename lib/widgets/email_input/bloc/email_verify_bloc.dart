import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:stream/repository/user_repository.dart';

part 'email_verify_event.dart';
part 'email_verify_state.dart';

class EmailVerifyBloc extends Bloc<EmailVerifyEvent, EmailVerifyState> {
  EmailVerifyBloc({
    required this.repository,
  })  : super(const EmailVerifyState());

  final UserRepository repository;

  @override
  Stream<EmailVerifyState> mapEventToState(EmailVerifyEvent event,) async* {
    if (event is Verify) {
      yield* _mapVerifyToState(event);
    }
  }

  Stream<EmailVerifyState> _mapVerifyToState(Verify event) async* {
    yield state.copyWith(status: CheckStatus.verifying,);

    try {
      final apiResponse = await repository.verifyEmail(event.email);

      if(apiResponse != null){
        if(apiResponse.code == 100){
          yield state.copyWith(status: CheckStatus.success,);
        }else{
          yield state.copyWith(status: CheckStatus.existing,);
        }

        return;
      }

      yield state.copyWith(status: CheckStatus.failure,);
    } catch (error) {
      yield state.copyWith(status: CheckStatus.failure,);
    }
  }
}
