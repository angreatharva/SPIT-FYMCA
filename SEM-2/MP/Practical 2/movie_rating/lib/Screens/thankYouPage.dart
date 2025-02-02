import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:movie_rating/Screens/mainScreen.dart';

import '../Controllers/formController.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({super.key});

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  final FormController formController = Get.put(FormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){
            formController.resetForm();
            Get.to(MainScreen());
          },
        ),
        centerTitle: true,
        backgroundColor: Color(0xffbed5ea),
        title: Text("Movies Rating App"),

      ),
      body: Container(
        color: Color(0xffffd46d),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                  Icons.mail_outline_rounded,size: 200,
                color: Colors.black,
                ),
              Text("Thank you for your valuable Review"),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black,width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                child:Column(
                  children: [
                    Text("Your Review"),
                    Text("Name: "+formController.box.read("name")),
                    Text("Surname: "+formController.box.read("surname")),
                    Text("Email Id: "+formController.box.read("emailId")),
                    Text("Phone Number: "+formController.box.read("phoneNumber")),
                    Text("Date of Birth: "+formController.box.read("dob")),
                    Text("Gender: "+formController.box.read("selectedGender")),
                    Text("Address: "+formController.box.read("address")),
                    Text("Review: "+formController.box.read("review")),
                    RatingBar.builder(
                      initialRating: formController.rating.value,
                      itemCount: 5,
                      minRating: 1,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return Icon(Icons.sentiment_very_dissatisfied, color: Colors.red);
                          case 1:
                            return Icon(Icons.sentiment_dissatisfied, color: Colors.redAccent);
                          case 2:
                            return Icon(Icons.sentiment_neutral, color: Colors.amber);
                          case 3:
                            return Icon(Icons.sentiment_satisfied, color: Colors.lightGreen);
                          case 4:
                            return Icon(Icons.sentiment_very_satisfied, color: Colors.green);
                          default:
                            return SizedBox.shrink();
                        }
                      },
                      ignoreGestures: true,
                      onRatingUpdate: (rating) {

                      },
                    ),
                  ],
                ),
              ),


              SizedBox(height: Get.height * 0.05,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: Get.width * 0.055,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.to(MainScreen());
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Colors.black,width: 2),
                        color: Color(0xffbed5ea),
                      ),
                      child: Text("Make Some Changes"),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(MainScreen());
                      formController.resetForm();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Colors.black,width: 2),
                        color: Color(0xffbed5ea),
                      ),
                      child: Text("Add Another"),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
