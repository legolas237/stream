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
    print('Starting Snack Resto services....');
    await Get.putAsync(() => StorageService().init());
    print('All Snack Resto services started...');
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
}
