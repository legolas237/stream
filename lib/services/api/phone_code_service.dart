import 'dart:convert';

import 'package:stream/models/base/api_response.dart';
import 'package:stream/services/base/base_service.dart';

class PhoneCodeService extends ApiClient {
  PhoneCodeService() : super() {
    url = baseUrl!.replaceFirst("{1}", "otp/{3}");
  }

  late String url;

  Future<ApiResponse?> send(String countryIsoCode, String telephone) async {
    var response = await httpClient.post(
      Uri.parse(url.replaceFirst('{3}', 'send')).toString(),
      data: {
        'country_code': countryIsoCode,
        'telephone': telephone,
      }
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(json.decode(response.data));
    }

    return null;
  }

  Future<ApiResponse?> verify(String otp, String telephone) async {
    var response = await httpClient.put(
        Uri.parse(url.replaceFirst('{3}', 'verify')).toString(),
        data: {
          'otp': otp,
          'telephone': telephone,
        }
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(json.decode(response.data));
    }

    return null;
  }

}
