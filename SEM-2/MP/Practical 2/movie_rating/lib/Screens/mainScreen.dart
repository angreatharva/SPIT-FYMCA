import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:movie_rating/Screens/thankYouPage.dart';

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
        backgroundColor: Color(0xffbed5ea),
        centerTitle: true,
        title: Text("Welcome to Movies Rating App"),
      ),
      body: Container(
        color: Color(0xffffd46d),
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
                      Focus(
                        onFocusChange: (hasFocus) {
                          if (!hasFocus) {
                            formController.validateName(formController.name.value.text);
                          }
                        },
                        child: Obx(()=>
                            TextFormField(
                              controller: formController.name.value,
                              onChanged: (value) {
                                formController.name.value.value = TextEditingValue(
                                  text: value,
                                  selection: TextSelection.collapsed(offset: value.length),
                                );
                                formController.validateName(value);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                labelText: 'Please Enter your Name',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: formController.nameError.value.isEmpty ? Colors.black : Colors.red,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: formController.nameError.value.isEmpty ? Colors.black : Colors.red,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorText: formController.nameError.value.isEmpty ? null : formController.nameError.value,
                                errorStyle: TextStyle(color: Colors.red),
                                filled: true,
                                fillColor: Colors.white,
                              ),
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
                      Text("Surname"),
                      Focus(
                        onFocusChange: (hasFocus) {
                          if (!hasFocus) {
                            formController.validateSurname(formController.surname.value.text);
                          }
                        },
                        child: Obx(()=>
                           TextFormField(
                            controller: formController.surname.value,
                            onChanged: (value) {
                              formController.surname.value.value = TextEditingValue(
                                text: value,
                                selection: TextSelection.collapsed(offset: value.length),
                              );
                              formController.validateSurname(value);
                            },
                             decoration: InputDecoration(
                               contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                               labelText: 'Please Enter your Surname',
                               enabledBorder: OutlineInputBorder(
                                 borderSide: BorderSide(
                                   color: formController.surnameError.value.isEmpty ? Colors.black : Colors.red,
                                   width: 2,
                                 ),
                                 borderRadius: BorderRadius.circular(8),
                               ),
                               focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(
                                   color: formController.surnameError.value.isEmpty ? Colors.black : Colors.red,
                                   width: 1.5,
                                 ),
                                 borderRadius: BorderRadius.circular(8),
                               ),
                               errorBorder: OutlineInputBorder(
                                 borderSide: BorderSide(color: Colors.red, width: 1.5),
                                 borderRadius: BorderRadius.circular(8),
                               ),
                               focusedErrorBorder: OutlineInputBorder(
                                 borderSide: BorderSide(color: Colors.red, width: 1.5),
                                 borderRadius: BorderRadius.circular(8),
                               ),
                               errorText: formController.surnameError.value.isEmpty ? null : formController.surnameError.value,
                               errorStyle: TextStyle(color: Colors.red),
                               filled: true,
                               fillColor: Colors.white,
                             ),
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
                      Text("Email Id"),
                      Focus(
                        onFocusChange: (hasFocus) {
                          if (!hasFocus) {
                            formController.validateEmail(formController.emailId.value.text);
                          }
                        },
                        child: Obx(()=>
                           TextFormField(
                            controller:  formController.emailId.value,
                            onChanged: (value) {
                              formController.emailId.value.value = TextEditingValue(
                                text: value,
                                selection: TextSelection.collapsed(offset: value.length),
                              );
                              formController.validateEmail(value);
                            },
                             decoration: InputDecoration(
                               contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                               labelText: 'Please Enter your Email Id',
                               enabledBorder: OutlineInputBorder(
                                 borderSide: BorderSide(
                                   color: formController.emailIdError.value.isEmpty ? Colors.black : Colors.red,
                                   width: 2,
                                 ),
                                 borderRadius: BorderRadius.circular(8),
                               ),
                               focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(
                                   color: formController.emailIdError.value.isEmpty ? Colors.black : Colors.red,
                                   width: 1.5,
                                 ),
                                 borderRadius: BorderRadius.circular(8),
                               ),
                               errorBorder: OutlineInputBorder(
                                 borderSide: BorderSide(color: Colors.red, width: 1.5),
                                 borderRadius: BorderRadius.circular(8),
                               ),
                               focusedErrorBorder: OutlineInputBorder(
                                 borderSide: BorderSide(color: Colors.red, width: 1.5),
                                 borderRadius: BorderRadius.circular(8),
                               ),
                               errorText: formController.emailIdError.value.isEmpty ? null : formController.emailIdError.value,
                               errorStyle: TextStyle(color: Colors.red),
                               filled: true,
                               fillColor: Colors.white,
                             ),
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
                      Text("Phone Number"),
                      Focus(
                        onFocusChange: (hasFocus) {
                          if (!hasFocus) {
                            formController.validatePhoneNumber(formController.phoneNumber.value.text);
                          }
                        },
                        child: Obx(()=>
                           TextFormField(
                            controller:  formController.phoneNumber.value,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            onChanged: (value) {
                              formController.phoneNumber.value.value = TextEditingValue(
                                text: value,
                                selection: TextSelection.collapsed(offset: value.length),
                              );
                              formController.validatePhoneNumber(value);
                            },
                             decoration: InputDecoration(
                               contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                               labelText: 'Please Enter your Phone Number',
                               enabledBorder: OutlineInputBorder(
                                 borderSide: BorderSide(
                                   color: formController.phoneNumberError.value.isEmpty ? Colors.black : Colors.red,
                                   width: 2,
                                 ),
                                 borderRadius: BorderRadius.circular(8),
                               ),
                               focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(
                                   color: formController.phoneNumberError.value.isEmpty ? Colors.black : Colors.red,
                                   width: 1.5,
                                 ),
                                 borderRadius: BorderRadius.circular(8),
                               ),
                               errorBorder: OutlineInputBorder(
                                 borderSide: BorderSide(color: Colors.red, width: 1.5),
                                 borderRadius: BorderRadius.circular(8),
                               ),
                               focusedErrorBorder: OutlineInputBorder(
                                 borderSide: BorderSide(color: Colors.red, width: 1.5),
                                 borderRadius: BorderRadius.circular(8),
                               ),
                               errorText: formController.phoneNumberError.value.isEmpty ? null : formController.phoneNumberError.value,
                               errorStyle: TextStyle(color: Colors.red),
                               filled: true,
                               fillColor: Colors.white,
                             ),
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
                      Text("Date of Birth"),
                      Obx(() =>
                          TextFormField(
                            controller: formController.dob.value,
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );

                              if (pickedDate != null) {
                                formController.dob.value.text = "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";

                                // Trigger validation after setting the DOB
                                formController.validateDob(formController.dob.value.text);
                              }
                            },
                            decoration: InputDecoration(
                                suffixIcon:Icon(Icons.calendar_month_rounded),
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              labelText: 'Please Enter your Date of Birth',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: formController.dobError.value.isEmpty ? Colors.black : Colors.red,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: formController.dobError.value.isEmpty ? Colors.black : Colors.red,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 1.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 1.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorText: formController.dobError.value.isEmpty ? null : formController.dobError.value,
                              errorStyle: TextStyle(color: Colors.red),
                              filled: true,
                              fillColor: Colors.white,
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
                            color: Colors.white,
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
                      Text("Movie Name"),
                      Obx(() =>
                          TextFormField(
                            controller: formController.movieName.value,
                            onChanged: (value) {
                              formController.movieName.value.value = TextEditingValue(
                                text: value,
                                selection: TextSelection.collapsed(offset: value.length),
                              );
                              formController.validateMovieName(value);
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              labelText: 'Please Enter Movie Name',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: formController.movieNameError.value.isEmpty ? Colors.black : Colors.red,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: formController.movieNameError.value.isEmpty ? Colors.black : Colors.red,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 1.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 1.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorText: formController.movieNameError.value.isEmpty ? null : formController.movieNameError.value,
                              errorStyle: TextStyle(color: Colors.red),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: Get.width * 0.45,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: Get.height * 0.010,
                    children: [
                      Text("Rating"),
                      Obx(() =>
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.015),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                    color: formController.ratingError.value.isEmpty
                                        ? Colors.black
                                        : Colors.red,
                                    width: 2
                                )
                            ),
                            child: RatingBar.builder(
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
                              onRatingUpdate: (rating) {
                                formController.rating.value = rating;
                                formController.validateRating(rating);
                              },
                            ),
                          ),
                      ),
                      Obx(() {
                        return formController.ratingError.value.isNotEmpty
                            ? Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            formController.ratingError.value,
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                            : SizedBox.shrink();
                      })

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
                      Focus(
                        onFocusChange: (hasFocus) {
                          if (!hasFocus) {
                            formController.validateAddress(formController.address.value.text);
                          }
                        },
                        child: Obx(()=>
                          TextFormField(
                            maxLines: 3,
                            controller:  formController.address.value,
                            onChanged: (value) {
                              formController.address.value.value = TextEditingValue(
                                text: value,
                                selection: TextSelection.collapsed(offset: value.length),
                              );
                              formController.validateAddress(value);
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              labelText: 'Please Enter your Address',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: formController.addressError.value.isEmpty ? Colors.black : Colors.red,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: formController.addressError.value.isEmpty ? Colors.black : Colors.red,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 1.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 1.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorText: formController.addressError.value.isEmpty ? null : formController.addressError.value,
                              errorStyle: TextStyle(color: Colors.red),
                              filled: true,
                              fillColor: Colors.white,
                            ),
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
                      Text("Review"),
                      Focus(
                        onFocusChange: (hasFocus) {
                          if (!hasFocus) {
                            formController.validateReview(formController.review.value.text);
                          }
                        },
                        child: Obx(()=>
                          TextFormField(
                            maxLines: 3,
                            controller:  formController.review.value,
                            onChanged: (value) {
                              formController.review.value.value = TextEditingValue(
                                text: value,
                                selection: TextSelection.collapsed(offset: value.length),
                              );
                              formController.validateReview(value);
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              labelText: 'Please Enter your Review',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: formController.reviewError.value.isEmpty ? Colors.black : Colors.red,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: formController.reviewError.value.isEmpty ? Colors.black : Colors.red,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 1.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 1.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorText: formController.reviewError.value.isEmpty ? null : formController.reviewError.value,
                              errorStyle: TextStyle(color: Colors.red),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            GestureDetector(
              onTap: () {
                formController.validateAllFields();
                if (formController.isFormValid()) {
                  print("name: "+formController.name.value.text);
                  formController.box.write('name', formController.name.value.text);
                  print("surname: " +formController.surname.value.text);
                  formController.box.write('surname', formController.surname.value.text);
                  print("emailId: "+formController.emailId.value.text);
                  formController.box.write('emailId', formController.emailId.value.text);
                  print("phoneNumber: "+formController.phoneNumber.value.text);
                  formController.box.write('phoneNumber', formController.phoneNumber.value.text);
                  print("dob: "+formController.dob.value.text);
                  formController.box.write('dob', formController.dob.value.text);
                  print("selectedGender: "+formController.selectedGender.value);
                  formController.box.write('selectedGender', formController.selectedGender.value);
                  print("address: "+formController.address.value.text);
                  formController.box.write('address', formController.address.value.text);
                  print("review: "+formController.review.value.text);
                  formController.box.write('review', formController.review.value.text);
                  print("Rating : "+formController.rating.value.toString());
                  formController.box.write('Rating',formController.rating.value );
                  print("Form submitted!");

                  Get.to(ThankYouPage());
                } else {
                  Get.snackbar(
                    'Error',
                    'Please fill all fields correctly',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.025,vertical: Get.height * 0.005),
                  decoration: BoxDecoration(
                    color: Color(0xffbed5ea),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.black, width: 2.5),
                  ),
                  child: Text("Submit")),
            ),
          ],
        ),
      ),
    );
  }
}