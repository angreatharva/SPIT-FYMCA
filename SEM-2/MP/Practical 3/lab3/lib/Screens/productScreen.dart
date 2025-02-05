import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: Get.height * 0.025,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: Get.width * 0.45,
                  height: Get.height * 0.50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: Get.height * 0.005,
                    children: [
                      Image.asset("assets/images/shoe1.png",height: Get.height * 0.25,),
                      Text("Nike Downshifter 13",
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20),
                          textAlign: TextAlign.center),
                      Text(
                          "Men's Road Running Shoe",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                          textAlign: TextAlign.center),
                      Text("MRP : ₹ 4,295.00",
                          style: TextStyle(fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500, fontSize: 15),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: Get.width * 0.45,
                  height: Get.height * 0.50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: Get.height * 0.005,
                    children: [
                      Image.asset("assets/images/shoe2.png",height: Get.height * 0.25,),
                      Text("Nike Dunk Low Retro",
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20),
                          textAlign: TextAlign.center),
                      Text(
                          "Men's Shoes",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                          textAlign: TextAlign.center),
                      Text("MRP : ₹ 8,295.00",
                          style: TextStyle(fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500, fontSize: 15),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
        
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: Get.width * 0.45,
                  height: Get.height * 0.50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: Get.height * 0.005,
                    children: [
                      Image.asset("assets/images/shoe3.png",height: Get.height * 0.25,),
                      Text("Nike Air Max Ishod",
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20),
                          textAlign: TextAlign.center),
                      Text(
                          "Men's Shoes",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                          textAlign: TextAlign.center),
                      Text("MRP : ₹ 9,207.00",
                          style: TextStyle(fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500, fontSize: 15),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: Get.width * 0.45,
                  height: Get.height * 0.50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: Get.height * 0.005,
                    children: [
                      Image.asset("assets/images/shoe4.png",height: Get.height * 0.25,),
                      Text("Nike Legend Essential 3 Next Nature",
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20),
                          textAlign: TextAlign.center),
                      Text(
                          "Men's Workout Shoes",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                          textAlign: TextAlign.center),
                      Text("MRP : ₹ 4,995.00",
                          style: TextStyle(fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500, fontSize: 15),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
        
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: Get.width * 0.45,
                  height: Get.height * 0.50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: Get.height * 0.005,
                    children: [
                      Image.asset("assets/images/shoe5.png",height: Get.height * 0.25,),
                      Text("Nike Impact 4",
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20),
                          textAlign: TextAlign.center),
                      Text(
                          "Basketball Shoes",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                          textAlign: TextAlign.center),
                      Text("MRP : ₹ 8,067.00",
                          style: TextStyle(fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500, fontSize: 15),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: Get.width * 0.45,
                  height: Get.height * 0.50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: Get.height * 0.005,
                    children: [
                      Image.asset("assets/images/shoe7.png",height: Get.height * 0.25,),
                      Text("Nike Free RN NN",
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20),
                          textAlign: TextAlign.center),
                      Text(
                          "Men's Road Running Shoes",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                          textAlign: TextAlign.center),
                      Text("MRP : ₹ 8,257.00",
                          style: TextStyle(fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500, fontSize: 15),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
