import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lab_ese/constants/themeConstants.dart';
import 'package:lab_ese/controllers/appointment_controller.dart';
import 'package:lab_ese/models/patient_model.dart';

class AppointmentsListScreen extends StatelessWidget {
  const AppointmentsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppointmentController controller = Get.find<AppointmentController>();
    
    controller.loadPatients();
    
    return Scaffold(
      backgroundColor: ThemeConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('All Appointments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.loadPatients,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (controller.patients.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 70,
                  color: ThemeConstants.textLightColor.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                const Text(
                  'No appointments found',
                  style: TextStyle(
                    fontSize: 18,
                    color: ThemeConstants.textSecondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Book your first appointment now!',
                  style: TextStyle(
                    color: ThemeConstants.textLightColor,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Book an Appointment'),
                ),
              ],
            ),
          );
        }
        
        return ListView.builder(
          itemCount: controller.patients.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final patient = controller.patients[index];
            return _buildAppointmentCard(patient);
          },
        );
      }),
    );
  }
  
  Widget _buildAppointmentCard(Patient patient) {
    final bool isUpcoming = patient.appointmentDate.isAfter(DateTime.now());
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: ThemeConstants.cardDecoration,
      child: Column(
        children: [

          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: isUpcoming ? ThemeConstants.primaryColor.withOpacity(0.1) : ThemeConstants.textLightColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.event,
                  size: 20,
                  color: isUpcoming ? ThemeConstants.primaryColor : ThemeConstants.textSecondaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  DateFormat('EEEE, MMMM dd, yyyy').format(patient.appointmentDate),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isUpcoming ? ThemeConstants.primaryColor : ThemeConstants.textSecondaryColor,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isUpcoming ? ThemeConstants.primaryColor : ThemeConstants.textLightColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isUpcoming ? 'Upcoming' : 'Past',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: ThemeConstants.primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          patient.name.isNotEmpty ? patient.name[0].toUpperCase() : '?',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: ThemeConstants.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            patient.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: ThemeConstants.textPrimaryColor,
                            ),
                          ),
                          Text(
                            'Age: ${patient.age} years',
                            style: const TextStyle(
                              color: ThemeConstants.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem(
                        icon: Icons.phone,
                        title: 'Contact',
                        value: patient.contactDetails,
                      ),
                    ),
                    Expanded(
                      child: _buildInfoItem(
                        icon: Icons.location_on_outlined,
                        title: 'Address',
                        value: patient.address,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem(
                        icon: Icons.medical_services_outlined,
                        title: 'Doctor',
                        value: patient.doctorName,
                      ),
                    ),
                    Expanded(
                      child: _buildInfoItem(
                        icon: Icons.sick_outlined,
                        title: 'Symptoms',
                        value: patient.symptoms,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required dynamic value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 16,
            color: ThemeConstants.textSecondaryColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: ThemeConstants.textLightColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value.toString(),
                  style: const TextStyle(
                    color: ThemeConstants.textPrimaryColor,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 