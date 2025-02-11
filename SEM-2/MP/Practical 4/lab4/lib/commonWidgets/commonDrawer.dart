import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab4/screens/companiesPage.dart';
import 'package:lab4/screens/profilePage.dart';
import 'package:lab4/screens/registerPage.dart';

class CommonDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xff1976D2),
            ),
            accountName: Text("Atharva Angre",style: TextStyle(color: Colors.white),),
            accountEmail: Text("angreatharva08@gmail.com",style: TextStyle(color: Colors.white),),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("AA"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Companies"),
            onTap: (){
              Get.back();
              Get.to(CompaniesPage());
            }
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
            onTap: (){
              Get.back();
              Get.to(ProfilePage());
            }
          ),
          ListTile(
            leading: Icon(Icons.app_registration_rounded),
            title: Text("Register"),
            onTap: (){
              Get.back();
              Get.to(RegisterPage());
            }
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
