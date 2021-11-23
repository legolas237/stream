import 'package:equatable/equatable.dart';

class Token extends Equatable {
  Token({
    required this.accessToken,
    required this.tokenType,
  });

  final String accessToken;
  final String tokenType;

  Token.fromJson(Map<String, dynamic> json)
      : accessToken = json['access_token'].toString(),
        tokenType = json['token_type'].toString();

  Map<String, dynamic> toJson() => <String, dynamic>{
    'access_token': accessToken,
    'token_type': tokenType,
  };

  @override
  List<Object?> get props => [accessToken, tokenType];
}
