import 'package:equatable/equatable.dart';

class Country extends Equatable {
  const Country({
    this.designation = "",
    required this.dialCode,
    required this.isoCode,
  });

  final String designation;
  final String dialCode;
  final String isoCode;

  Country.fromJson(Map<String, dynamic> json)
      : designation = json['designation'].toString(),
        dialCode = json['dial_code'].toString(),
        isoCode = json['alpha_code'].toString();

  Map<String, dynamic> toJson() => <String, dynamic>{};

  @override
  List<Object?> get props => [designation, dialCode, isoCode];
}
