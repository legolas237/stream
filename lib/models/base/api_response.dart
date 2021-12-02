import 'package:equatable/equatable.dart';
import 'package:stream/models/remote/country.dart';
import 'package:stream/models/remote/user.dart';

class ApiResponse extends Equatable{
  ApiResponse({
    required this.code,
    this.message,
    this.data,
  });

  final int code;
  final String? message;
  final dynamic data;

  ApiResponse.fromJson(Map<String, dynamic> json)
      : code = int.parse(json['code'].toString()),
        message = json['message'].toString(),
        data = json['data'];

  Map<String, dynamic> toJson() => <String, dynamic>{
    'code': code,
    'message': message,
    'data': data,
  };

  @override
  List<Object?> get props => [data, message, code,];

  // Deserialization

  User? deserializeUser() {
    if(data == null) return null;

    return User.fromJson(data);
  }

  List<Country> deserializeCountries() {
    if(data == null) return [];

    return (data as List).map((item) {
      return Country.fromJson(item);
    }).toList();
  }
}
