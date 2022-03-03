import 'package:stream/models/remote/user.dart';

import 'package:stream/services/api/user_service.dart';

class SyncWork {
  SyncWork._constructor();

  static final SyncWork _instance = SyncWork._constructor();

  static SyncWork get instance => _instance;

  Future<User?> fetchUserData() async {
    return await UserService().requestUserData();
  }
}