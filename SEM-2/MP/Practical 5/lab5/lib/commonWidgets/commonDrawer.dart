import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../Screens/webView.dart';

class CommonDrawer extends StatefulWidget {
  @override
  State<CommonDrawer> createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "Hello,\nAtharva Angre",
              style: TextStyle(color: Colors.white),
            ),
            accountEmail: Text(
              "angreatharva08@gmail.com",
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(
              color: Colors.amber
            ),
          ),
          ListTile(
              leading: Icon(Icons.event_note_rounded),
              title: Text("Events"),
              onTap: () {
                Get.back();
                // Get.to(CompaniesPage());
              }),
          ListTile(
              leading: Icon(Icons.phonelink_outlined),
              title: Text("Go to Web"),
              onTap: () {
                Get.back();
                Get.to(WebViewPage());
              }),
          ListTile(
              leading: Icon(Icons.feed_outlined),
              title: Text("Feedback"),
              onTap: () {
                Get.back();
                // Get.to(RegisterPage());
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
