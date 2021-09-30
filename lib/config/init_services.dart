import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:stream/repository/storage_repository.dart';

class StorageService extends GetxService {
  Future<StorageService> init() async {
    await GetStorage.init();
    StorageRepository.init();

    return this;
  }
}