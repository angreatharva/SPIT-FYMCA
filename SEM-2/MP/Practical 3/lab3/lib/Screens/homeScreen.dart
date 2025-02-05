import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../Controllers/homeScreenController.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        spacing: Get.height * 0.02,
        children: [
          Column(
            children: [
              Container(
                width: Get.width * 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: Get.height * 0.025,
                  children: [
                    Text(
                      "YOUR FEET DESERVE",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 40),
                    ),
                    Text(
                      "THE BEST",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 40),
                    ),
                  ],
                ),
              ),
              Image.asset(
                "assets/images/NIKE_Main.jpeg",
                height: Get.height * 0.2,
              ),
              Container(
                width: Get.width * 1,
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.025),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: Get.height * 0.025,
                  children: [
                    Text(
                        "Experience unmatched comfort and style with shoes crafted for every step. Because your feet deserve nothing but the best.",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "Visit Our Stores",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Get.width * 0.055),
                // color: Colors.blue,
                padding: EdgeInsets.zero,
                child: SingleChildScrollView(
                  child: Column(
                    spacing: Get.height * 0.025,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
                        width: Get.width * 0.8,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          spacing: Get.height * 0.005,
                          children: [
                            Icon(Icons.location_on_outlined),
                            Text("Nike Jio World Drive",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 20),
                                textAlign: TextAlign.center),
                            Text(
                                "G-32 & F-30, Jio World Drive Mall, Makers Maxity Avenue, Near Family court, Bandra Kurla Complex, Bandra East Mumbai, Maharashtra, 400051.",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20),
                                textAlign: TextAlign.center),
                            Text("Opens at 9:00 am • Closes at 10:00 pm",
                                style: TextStyle(fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w500, fontSize: 15),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
                        padding: EdgeInsets.all(10),
                        width: Get.width * 0.8,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          spacing: Get.height * 0.005,
                          children: [
                            Icon(Icons.location_on_outlined),
                            Text("Nike Colaba 1",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 20),
                                textAlign: TextAlign.center),
                            Text(
                                "Shahid Bhagat Singh Marg, Colaba,Mumbai, Maharashtra, 400001.",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20),
                                textAlign: TextAlign.center),
                            Text("Opens at 9:00 am • Closes at 10:00 pm",
                                style: TextStyle(fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w500, fontSize: 15),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      )),
    );
  }
}
