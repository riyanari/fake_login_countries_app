import 'package:get/get.dart';

import '../controllers/formC.dart';

class FormB extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormC>(() => FormC());
  }
}
