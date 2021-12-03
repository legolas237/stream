import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:stream/blocs/auth/auth_bloc.dart';
import 'package:stream/models/remote/user.dart';
import 'package:stream/repository/storage_repository.dart';
import 'package:stream/repository/user_repository.dart';

part 'unlock_account_event.dart';
part 'unlock_account_state.dart';

class UnlockAccountBloc extends Bloc<UnlockAccountEvent, UnlockAccountState> {
  UnlockAccountBloc({
    required this.userRepository,
    required this.authBloc,
  }) : super(UnlockAccountState());

  final UserRepository userRepository;
  final AuthBloc authBloc;

  @override
  Stream<UnlockAccountState> mapEventToState(UnlockAccountEvent event) async* {
    if (event is UnlockAccount) {
      yield* _mapUnlockToState(event);
    }
  }

  Stream<UnlockAccountState> _mapUnlockToState(UnlockAccount event,) async* {
    yield state.copyWith(status: UnlockStatus.processing,);

    try {
      var apiResponse = await userRepository.authenticate(
        event.phoneNumber,
        event.password,
      );

      if(apiResponse != null){
        switch(apiResponse.code) {
          case 100: // Okay
            // Get token and store it
            var token = apiResponse.data['plainTextToken'];
            var abilities = apiResponse.data['accessToken']['abilities'] as List;

            // Get auth user infos
            apiResponse = await userRepository.authUser(token);

            if(apiResponse != null && apiResponse.code == 100){
              // Get Auth user and store it
              var user = apiResponse.deserializeUser();

              if(user != null) {
                await StorageRepository.setToken(token);
                user.abilities = abilities;
                await StorageRepository.setUser(user);

                // Notify auth bloc
                authBloc.add(
                  AuthStatusChanged(
                    status: AuthStatus.authenticated,
                    user: user,
                  ),
                );

                yield state.copyWith(
                  status: UnlockStatus.unlocked,
                );
                return;
              }
            }

            yield state.copyWith(status: UnlockStatus.error);
            break;
          case 150: // Validation error
            yield state.copyWith(
              status: UnlockStatus.error,
              messages: apiResponse.data as Map<String, dynamic>,
            );
            break;
          default: // Error, Unable to verify telephone
            yield state.copyWith(
              status: UnlockStatus.error,
              messages: apiResponse.message,
            );
            break;
        }
      } else {
        yield state.copyWith(status: UnlockStatus.error, messages: null,);
      }
    } catch (error) {
      yield state.copyWith(status: UnlockStatus.error, messages: null,);
    }
  }
}
