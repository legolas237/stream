import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stream/models/remote/token.dart';
import 'dart:convert';

import 'package:stream/models/util/config.dart';
import 'package:stream/models/remote/user.dart';
import 'package:stream/config/config.dart';

class StorageRepository {
  static late GetStorage? _storage;

  static const userKey = 'USER';
  static const configKey = 'CONFIG';
  static const tokenKey = 'TOKEN';

  static void init() {
    _storage = GetStorage();
  }

  static GetStorage _instance() {
    if (_storage == null) GetStorage.init();
    return _storage!;
  }

  static Future<void> setConfig(Config config) async {
    await _instance().write(userKey, json.encode(config.toJson()));
  }

  static Config? getConfig() {
    final box = _instance();
    final data =  box.hasData(configKey) ? box.read(configKey) : null;

    if(data != null){
      return Config.fromJson(json.decode(data) as Map<String, dynamic>);
    }

    return null;
  }

  static Future<void> setUser(User user) async {
    await _instance().write(userKey, json.encode(user.toJson()));
  }

  static User? getUser() {
    final box = _instance();
    final data =  box.hasData(userKey) ? box.read(userKey) : null;

    if(data != null){
      return User.fromJson(json.decode(data) as Map<String, dynamic>);
    }

    return null;
  }

  static String getLanguage(){
    var config = StorageRepository.getConfig();

    if(config != null && config.language != null){
      return config.language!.toLowerCase();
    }

    final deviceLocale = Get.deviceLocale;
    if(deviceLocale != null) {
      return deviceLocale.languageCode.toUpperCase().toString();
    }

    return Constants.defaultLanguage.toLowerCase();
  }

  static Future<void> setToken(Token token) async {
    await _instance().write(tokenKey, token.accessToken);
  }

  static String? getToken() {
    final box = _instance();
    return box.hasData(tokenKey) ? box.read(tokenKey) : null;
  }

  static Future<void> clearAll() async {
    await _instance().erase();
  }
}
