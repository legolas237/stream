import 'dart:convert';

import 'package:stream/models/base/api_response.dart';
import 'package:stream/services/base/base_service.dart';

class UserService extends ApiClient {
  UserService() : super();

  Future<ApiResponse?> verifyEmail(String email) async {
    var response = await httpClient.get(
      Uri.parse(
          baseUrl!.replaceFirst('{1}', 'public/users/email/{2}',).replaceFirst('{2}', email)
      ).toString(),
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(json.decode(response.data));
    }

    return null;
  }

  Future<ApiResponse?> verifyUserName(String username) async {
    var response = await httpClient.get(
      Uri.parse(
          baseUrl!.replaceFirst('{1}', 'public/users/username/{2}',).replaceFirst('{2}', username)
      ).toString(),
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(json.decode(response.data));
    }

    return null;
  }

}
