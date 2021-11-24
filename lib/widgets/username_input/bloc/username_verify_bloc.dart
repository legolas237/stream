import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:stream/repository/user_repository.dart';

part 'username_verify_event.dart';
part 'username_verify_state.dart';

class UsernameVerifyBloc extends Bloc<UsernameVerifyEvent, UsernameVerifyState> {
  UsernameVerifyBloc({
    required this.repository,
  })  : super(const UsernameVerifyState());

  final UserRepository repository;

  @override
  Stream<UsernameVerifyState> mapEventToState(UsernameVerifyEvent event,) async* {
    if (event is Verify) {
      yield* _mapVerifyToState(event);
    }
  }

  Stream<UsernameVerifyState> _mapVerifyToState(Verify event) async* {
    yield state.copyWith(status: CheckStatus.verifying,);

    try {
      final apiResponse = await repository.verifyUserName(event.username,);

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
