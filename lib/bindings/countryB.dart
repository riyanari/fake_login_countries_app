import 'package:get/get.dart';

import '../api/my_api.dart';
import '../controllers/countryC.dart';
import '../providers/countryP.dart';

class CountryB extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyApi>(() => MyApi(), fenix: true);
    Get.lazyPut<CountryP>(() => CountryP(Get.find<MyApi>()), fenix: true);
    Get.lazyPut<CountryC>(() => CountryC(Get.find<CountryP>()));
  }
}
