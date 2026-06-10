import 'package:get/get.dart';

class ThemeC extends GetxController {
  final isDark = false.obs;

  void toggleTheme() {
    isDark.value = !isDark.value;
  }
}
