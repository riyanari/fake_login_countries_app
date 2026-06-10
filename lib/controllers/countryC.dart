import 'package:get/get.dart';

import '../models/country_model.dart';
import '../providers/countryP.dart';

class CountryC extends GetxController {
  CountryC(this.countryProvider);

  final CountryP countryProvider;

  final isLoading = false.obs;
  final isLoadMore = false.obs;
  final errorMessage = ''.obs;
  final searchKeyword = ''.obs;

  final allCountries = <CountryModel>[].obs;
  final filteredCountries = <CountryModel>[].obs;
  final countries = <CountryModel>[].obs;

  final int limit = 15;
  int currentPage = 1;

  bool get hasMore => countries.length < filteredCountries.length;

  @override
  void onInit() {
    super.onInit();
    getCountries();
  }

  Future<void> getCountries() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await countryProvider.fetchCountries();

      allCountries.assignAll(result);

      allCountries.sort((a, b) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });

      applySearch(searchKeyword.value);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void applySearch(String value) {
    searchKeyword.value = value;
    currentPage = 1;

    final keyword = value.trim().toLowerCase();

    if (keyword.isEmpty) {
      filteredCountries.assignAll(allCountries);
    } else {
      filteredCountries.assignAll(
        allCountries.where((country) {
          final name = country.name.toLowerCase();
          final capital = country.capital.toLowerCase();

          return name.contains(keyword) || capital.contains(keyword);
        }).toList(),
      );
    }

    countries.clear();
    loadFirstPage();
  }

  void loadFirstPage() {
    final firstData = filteredCountries.take(limit).toList();
    countries.assignAll(firstData);
  }

  Future<void> loadMore() async {
    if (isLoadMore.value) return;
    if (!hasMore) return;

    isLoadMore.value = true;

    await Future.delayed(const Duration(milliseconds: 500));

    currentPage++;

    final nextData = filteredCountries
        .skip((currentPage - 1) * limit)
        .take(limit)
        .toList();

    countries.addAll(nextData);

    isLoadMore.value = false;
  }

  Future<void> refreshCountries() async {
    currentPage = 1;
    await getCountries();
  }
}