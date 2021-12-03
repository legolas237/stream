part of 'upload_avatar_bloc.dart';

@immutable
abstract class UploadAvatarState extends Equatable {
  const UploadAvatarState();

  @override
  List<Object?> get props => [];
}

class UploadAvatarInitial extends UploadAvatarState {
  @override
  String toString() => 'UploadAvatarInitial';
}

class Uploading extends UploadAvatarState {
  @override
  String toString() => 'Uploading';
}

class Uploaded extends UploadAvatarState {
  @override
  String toString() => 'StartInitial';
}

class UploadFailed extends UploadAvatarState {
  const UploadFailed({this.message});

  final String? message;

  @override
  String toString() => 'UploadFailed';

  @override
  List<Object?> get props => [message];
}