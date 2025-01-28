import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

TextEditingController name = TextEditingController();
TextEditingController surname = TextEditingController();
TextEditingController dob = TextEditingController();
TextEditingController address = TextEditingController();
TextEditingController emailId = TextEditingController();
TextEditingController phoneNumber = TextEditingController();
var selectedGender = 'Male';
TextEditingController review = TextEditingController();
TextEditingController ratings = TextEditingController();

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Welcome to Movies Rating App"),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          spacing: Get.height * 0.025,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: Get.width * 0.45,
                  child: Column(
                    spacing: Get.height * 0.010,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name"),
                      TextFormField(
                          controller: name,
                          decoration: InputDecoration(
                              labelText: 'Please Enter your Surname',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(10),
                              )))
                    ],
                  ),
                ),
                Container(
                  width: Get.width * 0.45,
                  child: Column(
                    spacing: Get.height * 0.010,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Surname"),
                      TextFormField(
                          controller: surname,
                          decoration: InputDecoration(
                              labelText: 'Please Enter your Surname',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(10),
                              )))
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: Get.width * 0.45,
                  child: Column(
                    spacing: Get.height * 0.010,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email Id"),
                      TextFormField(
                          controller: emailId,
                          decoration: InputDecoration(
                              labelText: 'Please Enter your Email Id',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(10),
                              )))
                    ],
                  ),
                ),
                Container(
                  width: Get.width * 0.45,
                  child: Column(
                    spacing: Get.height * 0.010,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Phone Number"),
                      TextFormField(
                          controller: phoneNumber,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              labelText: 'Please Enter your Phone Number',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(10),
                              )))
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: Get.width * 0.45,
                  child: Column(
                    spacing: Get.height * 0.010,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date of Birth"),
                      TextFormField(
                        controller: dob,
                        readOnly: true, // Make the field non-editable
                        decoration: InputDecoration(
                            labelText: 'Select your Date of Birth',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: Icon(Icons.date_range_rounded)),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(), // Default date
                            firstDate: DateTime(1900), // Earliest date
                            lastDate: DateTime.now(), // Latest date
                          );

                          if (pickedDate != null) {
                            // Format the selected date and update the controller
                            dob.text =
                                "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  width: Get.width * 0.45,
                  child: Column(
                    spacing: Get.height * 0.010,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Gender"),
                      Container(
                        width: Get.width * 0.21,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          spacing: Get.height * 0.050,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: 'Male',
                                  groupValue: selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value!;
                                    });
                                  },
                                ),
                                Text('Male'),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 'Female',
                                  groupValue: selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value!;
                                    });
                                  },
                                ),
                                Text('Female'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: Get.width * 0.45,
                  child: Column(
                    spacing: Get.height * 0.010,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Address"),
                      TextFormField(
                          maxLines: 3,
                          controller: address,
                          decoration: InputDecoration(
                              labelText: 'Please Enter your Address',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(10),
                              )))
                    ],
                  ),
                ),
                Container(
                  width: Get.width * 0.45,
                  child: Column(
                    spacing: Get.height * 0.010,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Review"),
                      TextFormField(
                          maxLines: 3,
                          controller: review,
                          decoration: InputDecoration(
                              labelText: 'Please Enter your Review',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(10),
                              )))
                    ],
                  ),
                )
              ],
            ),
            Column(
              spacing: Get.height * 0.010,
              children: [
                Text("Rating"),
                RatingBar.builder(
                  initialRating: 0,
                  itemCount: 5,
                  minRating: 1,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Icon(
                          Icons.sentiment_very_dissatisfied,
                          color: Colors.red,
                        );
                      case 1:
                        return Icon(
                          Icons.sentiment_dissatisfied,
                          color: Colors.redAccent,
                        );
                      case 2:
                        return Icon(
                          Icons.sentiment_neutral,
                          color: Colors.amber,
                        );
                      case 3:
                        return Icon(
                          Icons.sentiment_satisfied,
                          color: Colors.lightGreen,
                        );
                      case 4:
                        return Icon(
                          Icons.sentiment_very_satisfied,
                          color: Colors.green,
                        );
                      default:
                        return SizedBox.shrink();
                    }
                  },
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ],
            ),
            ElevatedButton(onPressed: (){}, child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}
