import 'package:dio/dio.dart';

import '../themes/constans.dart';

class MyApi {
  MyApi()
      : dio = Dio(
    BaseOptions(
      baseUrl: AppConstans.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {'Accept': 'application/json'},
    ),
  );

  final Dio dio;

  Future<Response<dynamic>> getCountries() {
    return dio.get('/all?fields=name,capital,currencies,flags');
  }
}
