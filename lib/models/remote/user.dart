import 'package:basic_utils/basic_utils.dart';
import 'package:stream/models/remote/user_detail.dart';

class User {
  User({
    required this.userDetail,
    this.avatar,
    this.profilePicture,
    this.abilities = const ['*'],
  });

  final UserDetail userDetail;
  final String? avatar;
  final String? profilePicture;
  List abilities;

  User.fromJson(Map<String, dynamic> json)
      : userDetail = UserDetail.fromJson(json['user_detail']),
        avatar = json['avatar'],
        profilePicture = json['profile_picture'],
        abilities = json['abilities'] != null ? json['abilities'] as List : const ['*'];

  Map<String, dynamic> toJson() => <String, dynamic>{
    "user_detail": userDetail.toJson(),
    "avatar": avatar,
    "profile_picture": profilePicture,
    "abilities": abilities,
  };

  @override
  List<Object?> get props => [
    avatar,
    userDetail,
    abilities,
  ];

  // Callback

  String smallName() {
    var names = userDetail.name.split(" +");

    if(names.length >= 2) {
      return StringUtils.capitalize('${names[0]} ${names[1]}', allWords: true,);
    }

    return StringUtils.capitalize(names[0], allWords: true,);
  }
}
