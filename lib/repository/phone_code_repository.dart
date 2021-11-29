import 'package:stream/models/base/api_response.dart';
import 'package:stream/services/api/phone_code_service.dart';

class PhoneCodeRepository {
  final PhoneCodeService service = PhoneCodeService();

  Future<ApiResponse?> send(String countryIsoCode, String telephone) async {
    return service.send(countryIsoCode, telephone);
  }

  Future<ApiResponse?> verify(String otp, String telephone) async {
    return service.verify(otp, telephone);
  }
}