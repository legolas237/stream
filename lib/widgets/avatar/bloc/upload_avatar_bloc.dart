import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:stream/blocs/auth/auth_bloc.dart';
import 'package:stream/repository/storage_repository.dart';
import 'package:stream/repository/user_repository.dart';

part 'upload_avatar_event.dart';
part 'upload_avatar_state.dart';

class UploadAvatarBloc extends Bloc<UploadAvatarEvent, UploadAvatarState> {
  UploadAvatarBloc({
    required this.userRepository,
    required this.authBloc,
  }) : super(UploadAvatarInitial());

  final UserRepository userRepository;
  final AuthBloc authBloc;

  @override
  Stream<UploadAvatarState> mapEventToState(UploadAvatarEvent event) async* {
    if (event is UploadAvatar) {
      yield* _mapUploadToState(event);
    }
  }

  Stream<UploadAvatarState> _mapUploadToState(UploadAvatar event,) async* {
    yield Uploading();

    try {
      var apiResponse = await userRepository.uploadAvatar(
        event.avatar,
      );

      if(apiResponse != null){
        if(apiResponse.code == 100) {
          var user = apiResponse.deserializeUser();

          if(user != null) {
            await StorageRepository.setUser(user);

            // Notify auth bloc
            authBloc.add(
              AuthStatusChanged(
                status: AuthStatus.authenticated,
                user: user,
              ),
            );

            yield Uploaded();
            return;
          } else {
            yield const UploadFailed();
            return;
          }
        } else {
          yield UploadFailed(message: apiResponse.message);
          return;
        }
      }

      yield const UploadFailed();
    } catch (error) {
      yield const UploadFailed();
    }
  }
}
