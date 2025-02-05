import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width * 1,
        // color: Colors.red,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.045),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Deliver to:",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "Atharva Angre",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 20),
                              ),
                            ],
                          ),
                          Container(
                            width: Get.width * 0.75,
                            child: Text(
                              "309,B-3, Ekta S.R.A, Lohiya Nagar,St. Francis road, Vile Parle(West), Mumbai - 400056 ",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                      Text(
                        "Edit",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 20),
                      )
                    ],
                  )),
              Container(
                  child: Column(
                spacing: Get.height * 0.015,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    width: Get.width * 1,
                    // height: Get.height * 0.50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      spacing: Get.height * 0.005,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              "assets/images/shoe8.png",
                              height: Get.height * 0.25,
                            ),
                            Text("Nike Free RN NN",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 20),
                                textAlign: TextAlign.center),
                            Text("Men's Road Running Shoes",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20),
                                textAlign: TextAlign.center),
                          ],
                        ),
                        Text("MRP : ₹ 8,257.00",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    width: Get.width * 1,
                    // height: Get.height * 0.50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      spacing: Get.height * 0.005,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              "assets/images/NIKE_Main.jpeg",
                              height: Get.height * 0.25,
                              width: Get.width * 0.55,
                            ),
                            Text("Nike Revolution RN ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 20),
                                textAlign: TextAlign.center),
                            Text("Men's Running Shoes",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20),
                                textAlign: TextAlign.center),
                          ],
                        ),
                        Text("MRP : ₹ 4,499.00",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ],
              )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Text(
                        "Coupon",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      )),
                  Container(
                    height: Get.height * 0.045,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: Get.width * 0.015),
                          child: Row(
                            // spacing: 20,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.025),
                                  child: Image.asset(
                                    "assets/images/couponIcon.png",
                                    height: Get.height * 0.025,
                                  )),
                              Text("Apply Coupon",
                                  style: TextStyle(fontSize: 15)),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Text(
                        "Price Details",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      )),
                  Container(
                    // height: Get.height * 0.045,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black)),
                    child: Column(
                      spacing: Get.height * 0.015,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: Get.width * 0.015),
                              child: Row(
                                // spacing: 20,
                                children: [
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Get.width * 0.025),
                                      child: Text("Total MRP")),
                                ],
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(right: 20),
                                child: Text("₹ 12756"))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: Get.width * 0.015),
                              child: Row(
                                // spacing: 20,
                                children: [
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Get.width * 0.025),
                                      child: Text("Discounted MRP")),
                                ],
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(right: 20),
                                child: Text("- ₹ 2000"))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: Get.width * 0.015),
                              child: Row(
                                // spacing: 20,
                                children: [
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Get.width * 0.025),
                                      child: Text("Platform Fee")),
                                ],
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(right: 20),
                                child: Text("₹ 20"))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: Get.width * 0.015),
                              child: Row(
                                // spacing: 20,
                                children: [
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Get.width * 0.025),
                                      child: Text("Shipping Fee")),
                                ],
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(right: 20),
                                child: Text("Free"))
                          ],
                        ),
                        Divider(
                          height: 10,
                          color: Colors.black,
                          thickness: 1,
                          indent : 10,
                          endIndent : 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: Get.width * 0.015),
                              child: Row(
                                // spacing: 20,
                                children: [
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Get.width * 0.025),
                                      child: Text("Total ")),
                                ],
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(right: 20),
                                child: Text("₹ 10776"))
                          ],
                        ),

                      ],
                    ),
                  ),


                ],
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: Get.width * 0.92,
                height: Get.height * 0.04,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Text("Place Order"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
