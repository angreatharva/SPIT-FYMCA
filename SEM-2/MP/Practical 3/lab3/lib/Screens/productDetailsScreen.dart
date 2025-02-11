import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/productScreenController.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductScreenController controller = Get.put(ProductScreenController());


  @override
  Widget build(BuildContext context) {

    var imagePath  = controller.box.read("Image");
    var Name = controller.box.read("Name");
    var Description = controller.box.read("Description");
    var longDescription = controller.box.read("longDescription");
    var MRP = controller.box.read("MRP");

    return Scaffold(

      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            alignment: Alignment.center,

              child: Image.asset(imagePath .toString(),height: Get.height * 0.4,)),
          Container(
            width: Get.width * 1,
            height: Get.height * 0.5175,
            decoration: BoxDecoration(
              color: Color(0xff262626)
            ),
            child: SingleChildScrollView(

              child: Column(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding:EdgeInsets.symmetric(vertical: Get.height *0.025,horizontal:Get.width *0.025 ),
                          child: Text("$Name",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 28),)),
                      Container(
                          padding:EdgeInsets.symmetric(vertical: Get.height *0.025,horizontal:Get.width *0.025 ),
                          child: Text("$Description",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 20),)),
                      Container(
                          padding:EdgeInsets.symmetric(vertical: Get.height *0.005,horizontal:Get.width *0.025 ),
                          child: Text("$longDescription",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 20),)),
                    ],
                  ),

                  Container(
                    margin: EdgeInsets.all(10),
                    width: Get.width * 0.92,
                    height: Get.height * 0.04,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xffEB595F),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Text("₹ "+"$MRP",style: TextStyle(color: Colors.white),),
                  )
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
