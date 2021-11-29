import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:stream/repository/user_repository.dart';

part 'telephone_verify_event.dart';
part 'telephone_verify_state.dart';

class TelephoneVerifyBloc extends Bloc<TelephoneVerifyEvent, TelephoneVerifyState> {
  TelephoneVerifyBloc({
    required this.repository,
  })  : super(const TelephoneVerifyState());

  final UserRepository repository;

  @override
  Stream<TelephoneVerifyState> mapEventToState(TelephoneVerifyEvent event,) async* {
    if (event is Verify) {
      yield* _mapVerifyToState(event);
    }
  }

  Stream<TelephoneVerifyState> _mapVerifyToState(Verify event) async* {
    yield state.copyWith(status: CheckStatus.verifying,);

    try {
      final apiResponse = await repository.verifyTelephone(event.telephone,);

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
