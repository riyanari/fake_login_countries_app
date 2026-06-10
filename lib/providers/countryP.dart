import '../api/my_api.dart';
import '../models/country_model.dart';

class CountryP {
  CountryP(this.api);

  final MyApi api;

  Future<List<CountryModel>> fetchCountries() async {
    final response = await api.getCountries();
    final data = response.data;

    if (data is! List) {
      throw Exception('Format data negara tidak valid');
    }

    final countries = data
        .map((item) => CountryModel.fromJson(item as Map<String, dynamic>))
        .toList();

    countries.sort((a, b) => a.name.compareTo(b.name));
    return countries;
  }
}
