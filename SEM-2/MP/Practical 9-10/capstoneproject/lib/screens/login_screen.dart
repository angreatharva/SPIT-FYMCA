import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../utils/theme_constants.dart';

class LoginScreen extends StatefulWidget {
  final String selfCallerId;

  const LoginScreen({Key? key, required this.selfCallerId}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginController controller;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    
    // Always create a fresh controller instance for login screen
    // This ensures we don't reuse old controllers
    if (Get.isRegistered<LoginController>()) {
      Get.delete<LoginController>(force: true);
    }
    
    // Create a new controller
    controller = Get.put(LoginController(selfCallerId: widget.selfCallerId));
    
    // Set form key
    controller.setFormKey(formKey);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConstants.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: Get.height - MediaQuery.of(context).padding.top,
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: Get.height * 0.06),
                  // Logo and App Name
                  Center(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(Get.width * 0.04),
                          decoration: BoxDecoration(
                            color: ThemeConstants.mainColor,
                            borderRadius: BorderRadius.circular(Get.width * 0.05),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.health_and_safety,
                            size: Get.width * 0.12,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Text(
                          'NeuraLife',
                          style: TextStyle(
                            color: ThemeConstants.mainColor,
                            fontSize: Get.width * 0.07,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.04, 
                            vertical: Get.height * 0.01
                          ),
                          decoration: BoxDecoration(
                            color: ThemeConstants.mainColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(Get.width * 0.05),
                          ),
                          child: Text(
                            'Your Health, Our Priority',
                            style: TextStyle(
                              color: ThemeConstants.mainColor,
                              fontSize: Get.width * 0.04,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.08),
                  
                  // Welcome Text
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: Get.width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: ThemeConstants.mainColor,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Text(
                    'Sign in to access your health dashboard',
                    style: TextStyle(
                      fontSize: Get.width * 0.04,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.03),
                  
                  // Email Field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Get.width * 0.04),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        hintText: 'Email Address',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: ThemeConstants.mainColor,
                          size: Get.width * 0.06,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Get.width * 0.04),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.04, 
                          vertical: Get.height * 0.02
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: Get.width * 0.04),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  
                  // Password Field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Get.width * 0.04),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: controller.passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: ThemeConstants.mainColor,
                          size: Get.width * 0.06,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          child: Icon(
                            _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: ThemeConstants.mainColor,
                            size: Get.width * 0.06,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Get.width * 0.04),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.04, 
                          vertical: Get.height * 0.02
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      obscureText: _obscurePassword,
                      style: TextStyle(fontSize: Get.width * 0.04),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  
                  SizedBox(height: Get.height * 0.04),
                  
                  // Login Button
                  Obx(() => ElevatedButton(
                    onPressed: controller.isLoading.value ? null : controller.handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeConstants.mainColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Get.width * 0.04),
                      ),
                      elevation: 2,
                    ),
                    child: controller.isLoading.value
                        ? SizedBox(
                            height: Get.width * 0.06,
                            width: Get.width * 0.06,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: Get.width * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  )),
                  
                  Spacer(),
                  
                  // Registration Options
                  Container(
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
                    child: Column(
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: Get.width * 0.04,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: controller.goToUserRegistration,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFC3DEA9), // Light green similar to health dashboard
                                  foregroundColor: ThemeConstants.mainColor,
                                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.015),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(Get.width * 0.04),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'Register as Patient',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.width * 0.035,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: Get.width * 0.04),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: controller.goToDoctorRegistration,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF95BF71), // Darker green similar to health dashboard
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.015),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(Get.width * 0.04),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'Register as Doctor',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.width * 0.035,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.03),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 