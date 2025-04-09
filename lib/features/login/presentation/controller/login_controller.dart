import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../materiel_purchase/presentation/bindings/materiel_purchase_binding.dart';
import '../../../materiel_purchase/presentation/pages/materiel_purchase.dart';
import '../../domain/usecases/login_user.dart';

class LoginController extends GetxController {
  final LoginUser loginUser;

  LoginController(this.loginUser);

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: 'interview@gmail.com');
  final passwordController = TextEditingController(text: '12345678');

  var rememberMe = false.obs;
  var isLoading = false.obs;

  final GetStorage box = GetStorage();

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    final email = emailController.text.trim();
    final password = passwordController.text;

    final success = await loginUser(email, password);
    isLoading.value = false;

    if (success) {
      if (rememberMe.value) {
        // Save token if user wants to remember
        // box.write('token', loginUser.token);  // assuming token is accessible
      }
      Get.snackbar('Success', 'Login successful');

      // Navigate with binding
      Get.offAll(
            () => const MaterialPurchaseScreen(),
        binding: MaterialPurchaseBinding(),
      );// Navigate to Material Purchase screen
    } else {
      Get.snackbar('Error', 'Login failed. Check credentials.');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
