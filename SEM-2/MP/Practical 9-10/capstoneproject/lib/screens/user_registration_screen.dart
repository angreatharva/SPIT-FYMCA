import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';
import '../utils/theme_constants.dart';


class UserRegistrationScreen extends StatefulWidget {
  const UserRegistrationScreen({Key? key}) : super(key: key);

  @override
  _UserRegistrationScreenState createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedGender = 'Male';
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConstants.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // App Bar with back button
                  SizedBox(height: Get.height * 0.02),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: ThemeConstants.mainColor,
                          size: Get.width * 0.05,
                        ),
                        onPressed: () => Get.back(),
                      ),
                      SizedBox(width: Get.width * 0.02),
                      Text(
                        'Patient Registration',
                        style: TextStyle(
                          color: ThemeConstants.mainColor,
                          fontSize: Get.width * 0.055,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: Get.height * 0.02),
                  
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
                            Icons.person_add,
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
                            vertical: Get.height * 0.01,
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
                  
                  SizedBox(height: Get.height * 0.04),
                  
                  // Registration Form
                  Text(
                    'Create Your Account',
                    style: TextStyle(
                      color: ThemeConstants.mainColor,
                      fontSize: Get.width * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Text(
                    'Fill in your details to register as a patient',
                    style: TextStyle(
                      fontSize: Get.width * 0.04,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.03),
                  
                  // Full Name Field
                  _buildTextField(
                    controller: _nameController,
                    icon: Icons.person_outline,
                    hint: 'Full Name',
                    validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                  ),
                  SizedBox(height: Get.height * 0.02),
                  
                  // Email Field
                  _buildTextField(
                    controller: _emailController,
                    icon: Icons.email_outlined,
                    hint: 'Email Address',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Get.height * 0.02),
                  
                  // Phone Field
                  _buildTextField(
                    controller: _phoneController,
                    icon: Icons.phone_outlined,
                    hint: 'Phone Number',
                    keyboardType: TextInputType.phone,
                    validator: (value) => value!.isEmpty ? 'Please enter your phone number' : null,
                  ),
                  SizedBox(height: Get.height * 0.02),
                  
                  // Age Field
                  _buildTextField(
                    controller: _ageController,
                    icon: Icons.calendar_today_outlined,
                    hint: 'Age',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your age';
                      }
                      final age = int.tryParse(value);
                      if (age == null || age < 0 || age > 120) {
                        return 'Please enter a valid age';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Get.height * 0.02),
                  
                  // Gender Dropdown
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
                    child: DropdownButtonFormField<String>(
                      value: _selectedGender,
                      decoration: InputDecoration(
                        hintText: 'Gender',
                        prefixIcon: Icon(
                          Icons.people_outline,
                          color: ThemeConstants.mainColor,
                          size: Get.width * 0.06,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Get.width * 0.04),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.04,
                          vertical: Get.height * 0.02,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      style: TextStyle(
                        fontSize: Get.width * 0.04,
                        color: Colors.black87,
                      ),
                      dropdownColor: Colors.white,
                      items: ['Male', 'Female', 'Other']
                          .map((gender) => DropdownMenuItem(
                                value: gender,
                                child: Text(gender),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
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
                      controller: _passwordController,
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
                          vertical: Get.height * 0.02,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      obscureText: _obscurePassword,
                      style: TextStyle(fontSize: Get.width * 0.04),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  
                  SizedBox(height: Get.height * 0.04),
                  
                  // Register Button
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleRegistration,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeConstants.mainColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Get.width * 0.04),
                      ),
                      elevation: 2,
                    ),
                    child: _isLoading
                        ? SizedBox(
                            height: Get.width * 0.06,
                            width: Get.width * 0.06,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Register',
                            style: TextStyle(
                              fontSize: Get.width * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  
                  SizedBox(height: Get.height * 0.02),
                  
                  // Login Link
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'Already have an account? Login',
                      style: TextStyle(
                        color: ThemeConstants.mainColor,
                        fontSize: Get.width * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return Container(
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
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: ThemeConstants.mainColor,
            size: Get.width * 0.06,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Get.width * 0.04),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.04,
            vertical: Get.height * 0.02,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        keyboardType: keyboardType,
        style: TextStyle(fontSize: Get.width * 0.04),
        validator: validator,
      ),
    );
  }

  Future<void> _handleRegistration() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final userData = {
        'userName': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'age': int.parse(_ageController.text),
        'gender': _selectedGender,
        'password': _passwordController.text,
      };

      final response = await AuthService.instance.registerUser(userData);

      if (response['registered']) {
        Get.back();
        Get.snackbar(
          'Success',
          'Registration successful! Please login.',
          backgroundColor: ThemeConstants.secondaryColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
} 