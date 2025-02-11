import 'package:flutter/material.dart';
import 'package:lab4/commonWidgets/commonDrawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("TPO",style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xff1976D2),
      ),
      drawer: CommonDrawer(),
    );
  }
}
