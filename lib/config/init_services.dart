import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stream/repository/device_repository.dart';

import 'package:stream/repository/storage_repository.dart';

class StorageService extends GetxService {
  Future<StorageService> init() async {
    await GetStorage.init();
    StorageRepository.init();

    return this;
  }
}

class PhoneNumberLibService extends GetxService {
  Future<PhoneNumberLibService> init() async {
    await FlutterLibphonenumber().init();
    return this;
  }
}

class DeviceInfoService extends GetxService {
  Future<DeviceInfoService> init() async {
    await DeviceRepository.initForPlatform();
    return this;
  }
}
