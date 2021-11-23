import 'package:stream/models/base/api_response.dart';
import 'package:stream/services/api/country_service.dart';

class CountryRepository {
  final CountryService service = CountryService();

  Future<ApiResponse?> supportedCountries() async {
    return service.supportedCountries();
  }
}
