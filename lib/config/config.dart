import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:stream/models/remote/country.dart';

class Constants {
  static const appName = "O'Stream";
  static const double minHorizontalPadding = 16.0;
  static const double horizontalPadding = 20.0;
  static const double verticalPadding = 20.0;
  static const double buttonHeight = 42.0;
  static const int otpLength = 6;
  static const String defaultLanguage = 'EN';
  static const List<String> supportedLanguages = ['EN', 'FR'];
  static const defaultCurrency = 'XAF';
  static const datePickersFormat = 'EEE, d MMM yyyy';
  static const defaultCountry = Country(dialCode: '+237', isoCode: 'CM');
  static Map mapDateTimeLocale =     {
    supportedLanguages[0].toLowerCase() : LocaleType.en,
    supportedLanguages[1].toLowerCase() : LocaleType.fr,
  };
}