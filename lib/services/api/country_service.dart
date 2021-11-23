import 'dart:convert';

import 'package:stream/models/base/api_response.dart';
import 'package:stream/services/base/base_service.dart';

class CountryService extends ApiClient {
  CountryService() : super() {
    _url = baseUrl!.replaceFirst('{1}', 'public/countries');
  }

  late String _url;

  Future<ApiResponse?> supportedCountries() async {
    var response = await httpClient.get(
      Uri.parse(_url).toString(),
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(json.decode(response.data));
    }

    return null;
  }
}
