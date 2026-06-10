import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/userC.dart';
import '../themes/colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final userC = Get.find<UserC>();

  @override
  void initState() {
    super.initState();
    userC.checkSession();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.public, color: AppColors.primary, size: 70),
            SizedBox(height: 16),
            Text(
              'Fake Login Countries',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
