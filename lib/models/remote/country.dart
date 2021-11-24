import 'package:equatable/equatable.dart';

class Country extends Equatable {
  const Country({
    this.designation = "",
    required this.dialCode,
    required this.alphaCode,
    this.nativeName = '',
  });

  final String designation;
  final String dialCode;
  final String alphaCode;
  final String nativeName;

  Country.fromJson(Map<String, dynamic> json)
      : designation = json['designation'].toString(),
        dialCode = '+${json['country_code'].toString()}',
        nativeName = json['native_name'].toString(),
        alphaCode = json['alpha_code'].toString();

  Map<String, dynamic> toJson() => <String, dynamic>{};

  @override
  List<Object?> get props => [designation, dialCode, alphaCode, nativeName];
}
