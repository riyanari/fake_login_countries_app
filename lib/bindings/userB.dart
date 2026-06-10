import 'package:get/get.dart';

import '../controllers/formC.dart';
import '../controllers/userC.dart';
import '../helper/session_helper.dart';
import '../providers/userP.dart';

class UserB extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SessionHelper>(() => SessionHelper(), fenix: true);
    Get.lazyPut<UserP>(() => UserP(Get.find<SessionHelper>()), fenix: true);
    Get.lazyPut<UserC>(() => UserC(Get.find<UserP>()), fenix: true);
    Get.lazyPut<FormC>(() => FormC(), fenix: true);
  }
}
