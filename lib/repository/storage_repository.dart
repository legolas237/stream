import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

import 'package:stream/models/util/config.dart';
import 'package:stream/models/remote/user.dart';
import 'package:stream/config/config.dart';

class StorageRepository {
  static late GetStorage? _storage;

  static const USER_KEY = 'USER';
  static const CONFIG_KEY = 'CONFIG';

  static void init() {
    _storage = GetStorage();
  }

  static GetStorage _instance() {
    if (_storage == null) GetStorage.init();
    return _storage!;
  }

  static Future<void> setConfig(Config config) async {
    await _instance().write(USER_KEY, json.encode(config.toJson()));
  }

  static Config? getConfig() {
    final box = _instance();
    final data =  box.hasData(CONFIG_KEY) ? box.read(CONFIG_KEY) : null;

    if(data != null){
      return Config.fromJson(json.decode(data) as Map<String, dynamic>);
    }

    return null;
  }

  static Future<void> setUser(User user) async {
    await _instance().write(USER_KEY, json.encode(user.toJson()));
  }

  static User? getUser() {
    final box = _instance();
    final data =  box.hasData(USER_KEY) ? box.read(USER_KEY) : null;

    if(data != null){
      return User.fromJson(json.decode(data) as Map<String, dynamic>);
    }

    return null;
  }

  static String getLanguage (){
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

  static Future<void> clearAll() async {
    await _instance().erase();
  }
}
