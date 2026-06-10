class CountryModel {
  CountryModel({
    required this.name,
    required this.capital,
    required this.flagPng,
  });

  final String name;
  final String capital;
  final String flagPng;

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    final nameJson = json['name'] as Map<String, dynamic>?;
    final flagsJson = json['flags'] as Map<String, dynamic>?;
    final capitalJson = json['capital'];

    return CountryModel(
      name: nameJson?['common']?.toString() ?? '-',
      capital: capitalJson is List && capitalJson.isNotEmpty
          ? capitalJson.first.toString()
          : '-',
      flagPng: flagsJson?['png']?.toString() ?? '',
    );
  }
}
