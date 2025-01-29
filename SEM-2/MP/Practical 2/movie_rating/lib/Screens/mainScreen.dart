import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../Controllers/formController.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FormController formController = Get.put(FormController());

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
                        controller: TextEditingController(text: formController.name.value),
                        onChanged: (value) {
                          formController.name.value = value;
                          formController.validateName(value);
                        },
                        decoration: InputDecoration(
                          labelText: 'Please Enter your Name',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorText: formController.nameError.value.isNotEmpty ? formController.nameError.value : null,
                        ),
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
                      Text("Surname"),
                      TextFormField(
                        controller: TextEditingController(text: formController.surname.value),
                        onChanged: (value) {
                          formController.surname.value = value;
                          formController.validateSurname(value);
                        },
                        decoration: InputDecoration(
                          labelText: 'Please Enter your Surname',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorText: formController.surnameError.value.isNotEmpty ? formController.surnameError.value : null,
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
                      Text("Email Id"),
                      TextFormField(
                        controller: TextEditingController(text: formController.emailId.value),
                        onChanged: (value) {
                          formController.emailId.value = value;
                          formController.validateEmail(value);
                        },
                        decoration: InputDecoration(
                          labelText: 'Please Enter your Email Id',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorText: formController.emailIdError.value.isNotEmpty ? formController.emailIdError.value : null,
                        ),
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
                      Text("Phone Number"),
                      TextFormField(
                        controller: TextEditingController(text: formController.phoneNumber.value),
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (value) {
                          formController.phoneNumber.value = value;
                          formController.validatePhoneNumber(value);
                        },
                        decoration: InputDecoration(
                          labelText: 'Please Enter your Phone Number',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorText: formController.phoneNumberError.value.isNotEmpty ? formController.phoneNumberError.value : null,
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
                      Text("Date of Birth"),
                      TextFormField(
                        controller: TextEditingController(text: formController.dob.value),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );

                          if (pickedDate != null) {
                            formController.dob.value = "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
                          }
                        },
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
                        ),
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
                        child: Obx(
                          ()=> Row(
                            spacing: Get.height * 0.050,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    value: 'Male',
                                    groupValue: formController.selectedGender.value,
                                    onChanged: (value) {
                                      formController.selectedGender.value = value!;
                                    },
                                  ),
                                  Text('Male'),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: 'Female',
                                    groupValue: formController.selectedGender.value,
                                    onChanged: (value) {
                                      formController.selectedGender.value = value!;
                                    },
                                  ),
                                  Text('Female'),
                                ],
                              ),
                            ],
                          ),
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
                        controller: TextEditingController(text: formController.address.value),
                        onChanged: (value) {
                          formController.address.value = value;
                          formController.validateAddress(value);
                        },
                        decoration: InputDecoration(
                          labelText: 'Please Enter your Address',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorText: formController.addressError.value.isNotEmpty ? formController.addressError.value : null,
                        ),
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
                      Text("Review"),
                      TextFormField(
                        maxLines: 3,
                        controller: TextEditingController(text: formController.review.value),
                        onChanged: (value) {
                          formController.review.value = value;
                          formController.validateReview(value);
                        },
                        decoration: InputDecoration(
                          labelText: 'Please Enter your Review',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorText: formController.reviewError.value.isNotEmpty ? formController.reviewError.value : null,
                        ),
                      ),
                    ],
                  ),
                ),
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
                  onRatingUpdate: (rating) {
                    formController.rating.value =rating;
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (formController.nameError.value.isEmpty &&
                    formController.surnameError.value.isEmpty &&
                    formController.emailIdError.value.isEmpty &&
                    formController.phoneNumberError.value.isEmpty &&
                    formController.addressError.value.isEmpty &&
                    formController.reviewError.value.isEmpty) {
                  print("name: "+formController.name.value);
                  print("surname: " +formController.surname.value);
                  print("emailId: "+formController.emailId.value);
                  print("phoneNumber: "+formController.phoneNumber.value);
                  print("dob: "+formController.dob.value);
                  print("selectedGender: "+formController.selectedGender.value);
                  print("address: "+formController.address.value);
                  print("review: "+formController.review.value);
                  print("Rating : "+formController.rating.value.toString());
                  print("Form submitted!");
                }
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
