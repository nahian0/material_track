// lib/splash/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../features/login/presentation/bindings/login_binding.dart';
import '../features/login/presentation/pages/login_page.dart';  // Adjust path

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GetStorage box = GetStorage();

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  void _checkToken() async {
    await Future.delayed(const Duration(seconds: 3)); // Splash duration

    final token = box.read('token');  // Check for the token
    if (token != null) {
      Get.offAll(() => LoginPage());  // Navigate to home screen
    } else {
      Get.offAll(() => LoginPage());  // Navigate to login screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/ic_badge.png', width: 150, height: 150),  // Splash logo
            const SizedBox(height: 20),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
