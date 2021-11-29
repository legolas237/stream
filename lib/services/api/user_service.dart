import 'dart:convert';

import 'package:stream/models/base/api_response.dart';
import 'package:stream/repository/device_repository.dart';
import 'package:stream/services/base/base_service.dart';

class UserService extends ApiClient {
  UserService() : super();

  Future<ApiResponse?> verifyTelephone(String telephone) async {
    var response = await httpClient.post(
        Uri.parse(baseUrl!.replaceFirst('{1}', 'public/users/verify-telephone')).toString(),
        data: {
          "telephone": telephone,
        },
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(json.decode(response.data));
    }

    return null;
  }

  Future<ApiResponse?> verifyEmail(String email) async {
    var response = await httpClient.get(
      Uri.parse(baseUrl!
              .replaceFirst(
                '{1}',
                'public/users/email/{2}',
              )
              .replaceFirst('{2}', email))
          .toString(),
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(json.decode(response.data));
    }

    return null;
  }

  Future<ApiResponse?> verifyUserName(String username) async {
    var response = await httpClient.get(
      Uri.parse(baseUrl!
              .replaceFirst(
                '{1}',
                'public/users/username/{2}',
              )
              .replaceFirst('{2}', username))
          .toString(),
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(json.decode(response.data));
    }

    return null;
  }

  Future<ApiResponse?> registration(Map<String, String> data) async {
    var response = await httpClient.post(
      Uri.parse(baseUrl!.replaceFirst('{1}', 'auth/registration')).toString(),
      data: {
        ...data,
        "device_name": DeviceRepository.deviceFullName(),
        "os": DeviceRepository.osRelease(),
        "device_id": DeviceRepository.deviceId()
      },
    );

    if (response.statusCode == 200) {
      // TODO Get token
      // TODO Get Auth user
      return ApiResponse.fromJson(json.decode(response.data));
    }

    return null;
  }
}
