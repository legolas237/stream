import 'package:stream/config/date_time_converter.dart';

class UserDetail {
  UserDetail({
    required this.telephone,
    required this.email,
    required this.name,
    required this.dateOfBirth,
  });

  final String telephone;
  final String email;
  final String name;
  final DateTime dateOfBirth;

  UserDetail.fromJson(Map<String, dynamic> json)
      : telephone = json['telephone'].toString(),
        email = json['email'].toString(),
        name = json['name'].toString(),
        dateOfBirth =const DateTimeConverter().fromJson(json['data_of_birth'] as String,);

  Map<String, dynamic> toJson() => <String, dynamic>{
    "telephone": telephone,
    "email": email,
    "name": name,
    "data_of_birth": dateOfBirth.toString(),
  };

  @override
  List<Object?> get props => [
    telephone,
    email,
    name,
    dateOfBirth,
  ];
}
