import 'package:stream/config/config.dart';

class Config {
  Config({
    this.language,
  });

  String? language;

  Config copyWith({
    String? language,
  }) {
    return Config(
      language: language ?? Constants.defaultLanguage,
    );
  }

  static Config fromJson(Map<String, dynamic> json) {
    return Config(
      language: json['language'] ?? Constants.defaultLanguage,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'language': this.language,
  };
}
