import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_track/splash/splash_screen.dart'; // Update this import as necessary
import 'features/login/presentation/bindings/login_binding.dart';
import 'features/login/presentation/pages/login_page.dart';
import 'features/materiel_purchase/presentation/bindings/materiel_purchase_binding.dart';
import 'features/materiel_purchase/presentation/pages/materiel_purchase.dart';  // Adjust path

void main() async {
  await GetStorage.init();  // Initialize GetStorage
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: LoginBinding(),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => SplashScreen(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginPage(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: '/MaterialPurchaseScreen',
          page: () => MaterialPurchaseScreen(),
          binding: MaterialPurchaseBinding(),
        ),
      ],
    );

  }
}
