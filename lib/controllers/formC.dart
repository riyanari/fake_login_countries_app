import 'package:get/get.dart';

class FormC extends GetxController {
  final isPasswordHidden = true.obs;

  void togglePassword() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }
}
