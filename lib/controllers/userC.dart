import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../providers/userP.dart';
import '../routes/routes_name.dart';

class UserC extends GetxController {
  UserC(this.userProvider);

  final UserP userProvider;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;
  final username = ''.obs;

  Future<void> checkSession() async {
    await Future.delayed(const Duration(milliseconds: 800));
    final loggedIn = await userProvider.isLogin();

    if (loggedIn) {
      username.value = await userProvider.getUsername();
      Get.offAllNamed(RoutesName.home);
    } else {
      Get.offAllNamed(RoutesName.login);
    }
  }

  Future<void> login() async {
    final user = usernameController.text.trim();
    final pass = passwordController.text.trim();

    if (user.isEmpty || pass.isEmpty) {
      Get.snackbar('Gagal', 'Username dan password wajib diisi');
      return;
    }

    isLoading.value = true;
    await userProvider.login(username: user, password: pass);
    username.value = user;
    isLoading.value = false;

    Get.offAllNamed(RoutesName.home);
  }

  Future<void> loadUser() async {
    username.value = await userProvider.getUsername();
  }

  Future<void> logout() async {
    await userProvider.logout();
    usernameController.clear();
    passwordController.clear();
    Get.offAllNamed(RoutesName.login);
  }
}
