import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/login_controller.dart'; // Update this path as per your folder structure

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.5,
              decoration: const BoxDecoration(
                color: Color(0xFF0052FE),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Replace the Icon with Image.asset
                  Image.asset(
                    'assets/images/ic_badge.png',  // Provide the path to your image asset
                    width: 60,  // You can adjust the size of the image
                    height: 60, // Adjust as needed
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Sign in to your",
                    style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Account",
                    style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Enter your email and password to log in",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),

            ),
            Container(
              transform: Matrix4.translationValues(0, -40, 0),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.emailController,
                      validator: (value) =>
                      value == null || value.isEmpty ? 'Enter email' : null,
                      decoration: InputDecoration(
                        hintText: 'interview@gmail.com',
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: controller.passwordController,
                      obscureText: true,
                      validator: (value) =>
                      value == null || value.isEmpty ? 'Enter password' : null,
                      decoration: InputDecoration(
                        hintText: '********',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: const Icon(Icons.visibility_off_outlined),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Obx(() => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (val) =>
                          controller.rememberMe.value = val ?? false,
                        )),
                        const Text('Remember me'),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Forgot Password ?', style: TextStyle(color: Color(0xFF0052FE))),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0052FE),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.login();
                          }
                        },
                        child: const Text("Log In", style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don’t have an account? "),
                        GestureDetector(
                          onTap: () {},
                          child: const Text("Sign Up", style: TextStyle(color: Color(0xFF0052FE))),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
