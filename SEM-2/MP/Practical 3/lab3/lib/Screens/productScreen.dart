import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lab3/Controllers/productScreenController.dart';
import 'package:lab3/Screens/productDetailsScreen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductScreenController controller = Get.put(ProductScreenController());

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
                GestureDetector(
                  onTap: (){
                    controller.box.write("Image","assets/images/shoe1.png");
                    controller.box.write("Name","Nike Downshifter 13");
                    controller.box.write("Description","Men's Road Running Shoe");
                    controller.box.write("longDescription","Whether you're starting your running journey or an expert eager to switch up your pace, the Downshifter 13 is down for the ride. With a revamped upper, cushioning and durability, it helps you find that extra gear or take that first stride towards chasing down your goals.");
                    controller.box.write("MRP","4,295.00");
                    Get.to(ProductDetailsScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: Get.width * 0.45,
                    height: Get.height * 0.35,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/images/shoe1.png",),
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
                ),
                GestureDetector(
                  onTap: (){
                    controller.box.write("Image","assets/images/shoe2.png");
                    controller.box.write("Name","Nike Dunk Low Retro");
                    controller.box.write("Description","Men's Shoes");
                    controller.box.write("longDescription",
                        "Created for the hardwood but taken to the streets, the Nike Dunk Low Retro returns with crisp overlays and original team colours. This basketball icon channels '80s vibes with premium leather in the upper that looks good and breaks in even better. Modern footwear technology helps bring the comfort into the 21st century.");
                    controller.box.write("MRP","8,295.00");
                    Get.to(ProductDetailsScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: Get.width * 0.45,
                    height: Get.height * 0.35,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/images/shoe2.png",),
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
                ),
        
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    controller.box.write("Image","assets/images/shoe3.png");
                    controller.box.write("Name","Nike Air Max Ishod");
                    controller.box.write("Description","Men's Shoes");
                    controller.box.write("longDescription",
                        "Infused with elements taken from iconic '90s hoops shoes, the Air Max Ishod is built with all the durability you need to skate hard. This creative twist on the original Ishod design features updated mesh, exposed Nike Air (with Max Air technology) and a cupsole that breaks in easily. Now step in and skate like you mean it.");
                    controller.box.write("MRP","9,207.00");
                    Get.to(ProductDetailsScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: Get.width * 0.45,
                    height: Get.height * 0.38,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/images/shoe3.png",),
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
                ),
                GestureDetector(
                  onTap: (){
                    controller.box.write("Image","assets/images/shoe4.png");
                    controller.box.write("Name","Nike Legend Essential 3 Next Nature");
                    controller.box.write("Description","Men's Workout Shoes");
                    controller.box.write("longDescription",
                        "Meet the trainer versatile enough to withstand the rigours of a fast-paced group class or a heavy day in the weight room. Equipped with a flat heel, high-abrasion materials and a flexible sole, it provides comfort and support that's ready to hit the gym. See the specks on the outsole? That means it's constructed with at least 8% Nike Grind material, made from scraps from the footwear-manufacturing process.﻿");
                    controller.box.write("MRP","4,995.00");
                    Get.to(ProductDetailsScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: Get.width * 0.45,
                    height: Get.height * 0.38,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                        Image.asset("assets/images/shoe4.png" ),
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
                ),
        
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    controller.box.write("Image","assets/images/shoe5.png");
                    controller.box.write("Name","Nike Impact 4");
                    controller.box.write("Description","Basketball Shoes");
                    controller.box.write("longDescription",
                        "MeElevate your game and your hops. Charged with Max Air cushioning in the heel, this lightweight, secure shoe helps you get off the ground confidently and land comfortably. Plus, rubber wraps up the sides for added durability and stability.");
                    controller.box.write("MRP","8,067.00");
                    Get.to(ProductDetailsScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: Get.width * 0.45,
                    height: Get.height * 0.35,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/images/shoe5.png",),
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
                ),
                GestureDetector(
                  onTap: (){
                    controller.box.write("Image","assets/images/shoe6.png");
                    controller.box.write("Name","Nike Free RN NN");
                    controller.box.write("Description","Men's Road Running Shoes");
                    controller.box.write("longDescription",
                        "If it's freedom you crave, this road runner can help turn you loose. Feathery and flexible, its barefoot feel and Flyknit upper will have you freewheeling with joy, ready to go a few more strides.");
                    controller.box.write("MRP","8,257.00");
                    Get.to(ProductDetailsScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: Get.width * 0.45,
                    height: Get.height * 0.35,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/images/shoe6.png"),
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
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
