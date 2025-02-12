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
    var resumeBox = formController.box.read("resume");
    var imageBox = formController.box.read("profileImage");
    var isPdf = formController.box.read("isPdf");
    var collegeNameGraduation =
        formController.box.read("collegeNameGraduation");
    var CGPA = formController.box.read("CGPA");
    var collegeNameSSC = formController.box.read("collegeNameSSC");
    var percentageSSC = formController.box.read("percentageSSC");
    var collegeNameHSC = formController.box.read("collegeNameHSC");
    var percentageHSC = formController.box.read("percentageHSC");

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff1976D2),
      ),
      body: resumeBox != null &&
              imageBox != null &&
              collegeNameGraduation != null &&
              CGPA != null &&
              collegeNameSSC != null &&
              percentageSSC != null &&
              collegeNameHSC != null &&
              percentageHSC != null
          ? SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: (imageBox != null)
                        ? CircleAvatar(
                            radius: 100,
                            backgroundImage: FileImage(File(imageBox)),
                          )
                        : Text("No profile image selected."),
                  ),
            
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.025),
                    child: Column(
                      spacing: 0,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Graduation
                        Text(
                          "Graduation",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 15,
                              children: [
                                Icon(Icons.school_rounded),
                                Text(collegeNameGraduation,style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 18),),
                              ],
                            ),
                            Row(
                              spacing: 15,
                              children: [
                                Text(CGPA + " CGPA",style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 18)),
                                Icon(Icons.leaderboard_rounded),
                              ],
                            )
                          ],
                        ),
            
                        // HSC
                        Text(
                          "HSC",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 15,
                              children: [
                                Icon(Icons.school_rounded),
                                Text(collegeNameHSC,style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 18)),
                              ],
                            ),
                            Row(
                              spacing: 15,
                              children: [
                                Text(percentageHSC + "%",style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 18)),
                                Icon(Icons.leaderboard_rounded),
                              ],
                            ),
                          ],
                        ),
            
                        // SSC
                        Text("SSC",
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 15,
                              children: [
                                Icon(Icons.school_rounded),
                                Text(collegeNameSSC,style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 18)),
                              ],
                            ),
                            Row(
                              spacing: 15,
                              children: [
                                Text(percentageSSC + "%",style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 18)),
                                Icon(Icons.leaderboard_rounded),
                              ],
                            ),
            
            
                          ],
                        ),
                      ],
                    ),
                  ),
            
                  // Resume
            
                  (resumeBox != null)
                      ?
                      // return
                      isPdf != null
                          ? Container(
                              height: Get.height * 0.5,
                              child: PDFView(filePath: resumeBox),
                            )
                          : Image.file(
                              File(resumeBox),
                              height: Get.height * 0.3,
                              fit: BoxFit.cover,
                            )
                      : Container(
                          child: Text("No Resume is selected."),
                        ),
                ],
              ),
          )
          : Center(
              child: Text("Please Register First!"),
            ),
    );
  }
}
