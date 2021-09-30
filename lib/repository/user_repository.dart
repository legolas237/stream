import 'package:stream/models/remote/user.dart';
import 'package:stream/repository/storage_repository.dart';

class UserRepository {

  User? getAuthUser() {
    return StorageRepository.getUser();
  }

}