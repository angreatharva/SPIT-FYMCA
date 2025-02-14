import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lab4/screens/companiesPage.dart';
import 'package:lab4/screens/profilePage.dart';
import 'package:lab4/screens/registerPage.dart';

import '../controllers/registrationController.dart';

class CommonDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FormController formController = Get.put(FormController());
    var isProfileComplete = formController.box.read("isProfileComplete");
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff1976D2),
              ),
              accountName: isProfileComplete != null
                  ? Text(
                      "Atharva Angre",
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      "----- -----",
                      style: TextStyle(color: Colors.white),
                    ),
              accountEmail: isProfileComplete != null
                  ? Text(
                      "angreatharva08@gmail.com",
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      "-----@gmail.com",
                      style: TextStyle(color: Colors.white),
                    ),
              currentAccountPicture:
              isProfileComplete != null
                      ? CircleAvatar(
                          radius: 100,
                          backgroundImage: FileImage(
                              File(formController.box.read("profileImage"))),
                        )
                      : CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.grey[200], // Background color for default
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.person, // Default icon
                          size: 50,
                          color: Colors.grey[700], // Icon color
                        ),
                      ],
                    ),
                  ),
          ),
          ListTile(
              leading: Icon(Icons.home),
              title: Text("Companies"),
              onTap: () {
                Get.back();
                Get.to(CompaniesPage());
              }),
          ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () {
                Get.back();
                Get.to(ProfilePage());
              }),
          ListTile(
              leading: Icon(Icons.app_registration_rounded),
              title: Text("Register"),
              onTap: () {
                Get.back();
                Get.to(RegisterPage());
              }),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Exit App"),
            onTap: () {
              SystemNavigator.pop();
            },
          ),
        ],
      ),
    );
  }
}
