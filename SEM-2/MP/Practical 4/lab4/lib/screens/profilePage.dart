import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

import '../controllers/registrationController.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FormController formController = Get.put(FormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff1976D2),
      ),
      body: Column(
        children: [
          //Image
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Obx(() {
              if (formController.profileImagePath.value != null) {
                return CircleAvatar(
                  radius:100,
                  backgroundImage: FileImage(File(formController.profileImagePath.value)),
                );
              } else {
                return Text("No profile image selected.");
              }
            }),
          ),

          //Graduation

          //HSC

          //SSC

          //Resume
          Obx(() {
            if (formController.selectedFilePath.isNotEmpty) {
              return formController.isPdf.value
                  ? Container(
                height: Get.height * 0.5,
                child: PDFView(
                    filePath:
                    formController.selectedFilePath.value),
              )
                  : Image.file(
                File(formController.selectedFilePath.value),
                height: Get.height * 0.3,
                fit: BoxFit.cover,
              );
            }
            return Container();
          }),

        ],
      ),
    );
  }
}
