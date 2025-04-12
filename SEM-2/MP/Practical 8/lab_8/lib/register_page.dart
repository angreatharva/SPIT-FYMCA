import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'auth_controller.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                Text(
                  "Create Account",
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ).animate().fadeIn().slideX(),
                const SizedBox(height: 8),
                Text(
                  "Sign up to get started",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ).animate().fadeIn().slideX(),
                const SizedBox(height: 40),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    hintText: "Enter your full name",
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ).animate().fadeIn().slideX(),
                const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Enter your email",
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ).animate().fadeIn().slideX(),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter your password",
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ).animate().fadeIn().slideX(),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    AuthController.to.registerUser(
                      nameController.text.trim(),
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Create Account",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ).animate().fadeIn().slideX(),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    "Already have an account? Sign In",
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ).animate().fadeIn().slideX(),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "OR",
                        style: GoogleFonts.poppins(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ).animate().fadeIn(),
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  onPressed: () => AuthController.to.signInWithGoogle(),
                  icon: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjzC2JyZDZ_RaWf0qp11K0lcvB6b6kYNMoqtZAQ9hiPZ4cTIOB",
                    height: 24,
                  ),
                  label: Text(
                    "Sign up with Google",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                ).animate().fadeIn().slideX(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
