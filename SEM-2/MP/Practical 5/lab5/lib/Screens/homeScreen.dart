import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab5/Screens/webView.dart';
import 'package:lab5/commonWidgets/commonDrawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('MCA Dept.'),
          leading: Builder(
            builder: (context) {
              return Hero(
                tag: 'SPIT_LOGO',
                child: IconButton(
                  icon: Image.asset('assets/images/spit.jpeg'),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              );
            }
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Faculty Information',),
              Tab(text: 'Vision and Mission',),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text("Faculty info")),
            Center(child: Text("Vision and Mission")),
          ],
        ),
        drawer: CommonDrawer(),

      ),
    );
  }
}
