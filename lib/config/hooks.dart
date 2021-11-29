import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import 'package:stream/config/init_services.dart';

class Hooks {
  static void setOrientation(List<DeviceOrientation> orientations) {
    SystemChrome.setPreferredOrientations(orientations);
  }

  static int tintValue(int value, double factor) {
    return max(0, min((value + ((255 - value) * factor)).round(), 255));
  }

  static Color tintColor(Color color, double factor) {
    return Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1,
    );
  }

  static int shadeValue(int value, double factor) {
    return max(0, min(value - (value * factor).round(), 255));
  }

  static Color shadeColor(Color color, double factor) {
    return Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1,
    );
  }

  static Future<void> initServices() async {
    debugPrint('Starting O\'Stream services....');
    await Get.putAsync(() => StorageService().init());
    await Get.putAsync(() => PhoneNumberLibService().init());
    await Get.putAsync(() => DeviceInfoService().init());
    debugPrint('All O\'Stream services started...');
  }

  static String formatDate(DateTime date, String format) {
    late String result = '';

    try {
      var momentDate = Moment.parse(date.toString());
      result = momentDate.format(format);
    } catch (_) {}

    return result;
  }

  static String formatAmountCurrency(double amount, String currency) {
    return toCurrencyString(
      amount.toString(),
      shorteningPolicy: amount > 1000000 ? ShorteningPolicy.RoundToMillions : ShorteningPolicy.NoShortening,
      trailingSymbol: currency.toUpperCase(),
      useSymbolPadding: true,
    );
  }

  static void prettyJson(Object? json) {
    if(json != null){
      JsonEncoder encoder = const JsonEncoder.withIndent(' ');
      String prettyPrint = encoder.convert(json);

      debugPrint(prettyPrint);
    }

    debugPrint('');
  }

  static String decodeJson(Object json) {
    JsonEncoder encoder = const JsonEncoder();
    return encoder.convert(json);
  }

  static bool isDigit(String value, int index) {
    return  "0".compareTo(value[index]) <= 0 && "9".compareTo(value[index]) >= 0;
  }

}
