import 'package:stream/models/base/api_response.dart';
import 'package:stream/models/remote/user.dart';
import 'package:stream/repository/storage_repository.dart';
import 'package:stream/services/api/user_service.dart';

class UserRepository {
  final UserService service = UserService();

  User? getAuthUser() {
    return StorageRepository.getUser();
  }

  Future<ApiResponse?> verifyEmail(String email) async {
    return service.verifyEmail(email);
  }

  Future<ApiResponse?> verifyUserName(String username) async {
    return service.verifyUserName(username);
  }

}