import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_ese/constants/themeConstants.dart';
import 'package:lab_ese/screens/appointment_screen.dart';
import 'package:lab_ese/screens/appointments_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConstants.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: ThemeConstants.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome to',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'NeuraLife',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Book your doctor appointments easily',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'What would you like to do?',
                      style: ThemeConstants.subheadingStyle,
                    ),
                    const SizedBox(height: 20),
                    
                    InkWell(
                      onTap: () => Get.to(() => AppointmentScreen()),
                      child: Container(
                        decoration: ThemeConstants.cardDecoration,
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: ThemeConstants.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: const Icon(
                                Icons.calendar_month_rounded,
                                color: ThemeConstants.primaryColor,
                                size: 32,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Book Appointment',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: ThemeConstants.textPrimaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Schedule a new appointment with one of our doctors',
                                    style: TextStyle(
                                      color: ThemeConstants.textSecondaryColor.withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: ThemeConstants.primaryColor,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    InkWell(
                      onTap: () => Get.to(() => AppointmentsListScreen()),
                      child: Container(
                        decoration: ThemeConstants.cardDecoration,
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: ThemeConstants.secondaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: const Icon(
                                Icons.list_alt_rounded,
                                color: ThemeConstants.secondaryColor,
                                size: 32,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'View Appointments',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: ThemeConstants.textPrimaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Check your upcoming appointments',
                                    style: TextStyle(
                                      color: ThemeConstants.textSecondaryColor.withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: ThemeConstants.secondaryColor,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(
          icon,
          color: ThemeConstants.primaryColor,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: ThemeConstants.textSecondaryColor,
          ),
        ),
      ],
    );
  }
} 