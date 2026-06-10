import 'package:get/get.dart';

import '../bindings/countryB.dart';
import '../bindings/userB.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/splash_page.dart';
import 'routes_name.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: RoutesName.splash,
      page: () => const SplashPage(),
      binding: UserB(),
    ),
    GetPage(
      name: RoutesName.login,
      page: () => const LoginPage(),
      binding: UserB(),
    ),
    GetPage(
      name: RoutesName.home,
      page: () => const HomePage(),
      bindings: [UserB(), CountryB()],
    ),
  ];
}
