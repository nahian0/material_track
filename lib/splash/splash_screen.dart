import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../core/services/api_client.dart';
import '../features/login/presentation/bindings/login_binding.dart';
import '../features/login/presentation/pages/login_page.dart';
import '../features/materiel_purchase/presentation/bindings/materiel_purchase_binding.dart';
import '../features/materiel_purchase/presentation/pages/materiel_purchase.dart'; // Adjust path

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
      ApiClient.setAuthHeader();
      // Token found, navigate to MaterialPurchaseScreen and initialize the binding
      Get.offAllNamed('/MaterialPurchaseScreen');
    } else {
      // Token not found, navigate to Login screen
      Get.offAllNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent, // Updated color for a fresh look
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Stylish logo with a slight drop shadow effect
            Container(
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))],
              ),
              child: Image.asset(
                'assets/images/ic_badge.png',
                width: 150,
                height: 150,
              ),
            ),
            const SizedBox(height: 30), // Increased spacing for better layout

            // Welcome Text
            const Text(
              'Welcome', // App name or slogan
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 10),

            // Loading Text
            const Text(
              'We are preparing everything for you...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 30), // Added space below

            // Circular Progress Indicator
            const CircularProgressIndicator(
              color: Colors.white, // Updated progress color
              strokeWidth: 4, // Slightly thicker indicator
            ),
          ],
        ),
      ),
    );
  }
}
