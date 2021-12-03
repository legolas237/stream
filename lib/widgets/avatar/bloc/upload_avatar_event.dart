part of 'upload_avatar_bloc.dart';

@immutable
abstract class UploadAvatarEvent extends Equatable{
  const UploadAvatarEvent();

  @override
  List<Object?> get props => [];
}

class UploadAvatar extends UploadAvatarEvent {
  const UploadAvatar(this.avatar);

  final File avatar;

  @override
  String toString() => 'UploadAvatar';

  @override
  List<Object?> get props => [avatar];
}
