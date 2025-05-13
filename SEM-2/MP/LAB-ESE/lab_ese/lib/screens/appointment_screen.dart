import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lab_ese/constants/doctors_list.dart';
import 'package:lab_ese/constants/themeConstants.dart';
import 'package:lab_ese/controllers/appointment_controller.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _symptomsController = TextEditingController();
  
  final AppointmentController _controller = Get.find<AppointmentController>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _controller.appointmentDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ThemeConstants.primaryColor,
              onPrimary: Colors.white,
              onSurface: ThemeConstants.textPrimaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      _controller.setAppointmentDate(picked);
    }
  }

  Future<void> _saveAppointment() async {
    if (_formKey.currentState!.validate()) {
      _controller.name.value = _nameController.text;
      _controller.address.value = _addressController.text;
      _controller.age.value = _ageController.text;
      _controller.contactDetails.value = _contactController.text;
      _controller.symptoms.value = _symptomsController.text;
      
      final result = await _controller.saveAppointment();
      
      if (result) {
        Get.back();
        Get.snackbar(
          'Success',
          'Appointment booked successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ThemeConstants.successColor,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to book appointment',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ThemeConstants.errorColor,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _ageController.dispose();
    _contactController.dispose();
    _symptomsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('Book Appointment'),
        centerTitle: true,
      ),
      body: Obx(() => _controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: ThemeConstants.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Complete Your Appointment Details',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Fill in the form below to book your appointment with our specialists',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Patient Information',
                      style: ThemeConstants.subheadingStyle,
                    ),
                    const SizedBox(height: 16),
                    _buildFormField(
                      controller: _nameController,
                      label: 'Patient Name',
                      icon: Icons.person,
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length <= 2) {
                          return 'Please enter patient name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildFormField(
                      controller: _addressController,
                      label: 'Address',
                      icon: Icons.home,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildFormField(
                            controller: _ageController,
                            label: 'Age',
                            icon: Icons.calendar_today,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter age';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildFormField(
                            controller: _contactController,
                            label: 'Contact Details',
                            icon: Icons.phone,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter contact details';
                              }
                              if (value.length != 10) {
                                return 'Please enter proper phone number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildFormField(
                      controller: _symptomsController,
                      label: 'Symptoms',
                      icon: Icons.medical_services,
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter symptoms';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Appointment Details',
                      style: ThemeConstants.subheadingStyle,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: ThemeConstants.textLightColor),
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Select Doctor',
                          prefixIcon: Icon(Icons.person_outline),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        value: _controller.selectedDoctor.value,
                        items: doctors.map((Doctor doctor) {
                          return DropdownMenuItem<String>(
                            value: doctor.name,
                            child: Text('${doctor.name} (${doctor.specialization})'),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            _controller.setSelectedDoctor(newValue);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () => _selectDate(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: ThemeConstants.textLightColor),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.event,
                              color: ThemeConstants.textSecondaryColor,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Appointment Date',
                                  style: TextStyle(
                                    color: ThemeConstants.textSecondaryColor,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Obx(() => Text(
                                  DateFormat('EEEE, MMM dd, yyyy').format(_controller.appointmentDate.value),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: ThemeConstants.textPrimaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _saveAppointment,
                        child: const Text(
                          'Book Appointment',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
      ),
    );
  }
  
  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }
} 