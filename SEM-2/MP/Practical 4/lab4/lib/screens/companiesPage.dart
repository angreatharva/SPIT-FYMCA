import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/registrationController.dart';

class CompaniesPage extends StatefulWidget {
  const CompaniesPage({super.key});

  @override
  State<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {

  @override
  Widget build(BuildContext context) {
    final FormController formController = Get.put(FormController());
    var isProfileComplete = formController.box.read("isProfileComplete");
    final List<List<String>> companies = [
      [
        'ISS stoxx',
        'Mumbai, India',
        '₹60,000 - ₹75,000',
        'SDE-1.',
        'assets/images/ISS.jpg'
      ],
      [
        'Nomura',
        'Mumbai, India',
        '₹80,000 - ₹90,000',
        'SDE-1.',
        'assets/images/Nomura.jpg'
      ],
      [
        'Oracle',
        'Mumbai, India',
        '₹70,000 - ₹80,000',
        'Associate Consultant.',
        'assets/images/oracle.png'
      ],
      [
        'Phone Pe',
        'Bangalore, India',
        '₹1,20,000 - ₹1,40,000',
        'Senior Devops Engineer.',
        'assets/images/phonePe.png'
      ],
      [
        'Wissen Infotech',
        'Bangalore, India',
        '₹70,000 - ₹80,000',
        'Database Engineer.',
        'assets/images/Wissen.jpg'
      ],
    ];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Companies",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff1976D2),
      ),
      body:
      isProfileComplete != null ?
      ListView.builder(
        itemCount: companies.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      companies[index][4],
                      width: 80,
                      height: 80,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: 15),
                  // Company Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          companies[index][0], // Company Name
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Location: ${companies[index][1]}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        Text(
                          'Salary Range: ${companies[index][2]}',
                          style: TextStyle(color: Color(0xffFF6600)),
                        ),
                        SizedBox(height: 5),
                        Text(
                          companies[index][3], // Short Profile
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ):
      Center(
        child: Text("Please Register First!"),
      ),
    );
  }
}
