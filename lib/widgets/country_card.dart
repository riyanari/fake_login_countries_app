import 'package:flutter/material.dart';

import '../models/country_model.dart';
import '../themes/colors.dart';

class CountryCard extends StatelessWidget {
  const CountryCard({super.key, required this.country});

  final CountryModel country;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: country.flagPng.isEmpty
              ? const SizedBox(width: 48, height: 34)
              : Image.network(
                  country.flagPng,
                  width: 48,
                  height: 34,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox(width: 48, height: 34),
                ),
        ),
        title: Text(
          country.name,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text('Ibukota: ${country.capital}'),
      ),
    );
  }
}
