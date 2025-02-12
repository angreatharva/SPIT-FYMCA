import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:lab4/screens/mainScreen.dart';

import '../controllers/registrationController.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FormController formController = Get.put(FormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Register",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff1976D2),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: Get.height * 0.015),
                      child: Text(
                        "Details About you",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 20),
                      )),

                  //Name
                  Container(
                    width: Get.width * 0.95,
                    child: Column(
                      spacing: Get.height * 0.010,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name"),
                        Focus(
                          onFocusChange: (hasFocus) {
                            if (!hasFocus) {
                              formController
                                  .validateName(formController.name.value.text);
                            }
                          },
                          child: Obx(
                            () => TextFormField(
                              controller: formController.name.value,
                              onChanged: (value) {
                                formController.name.value.value =
                                    TextEditingValue(
                                  text: value,
                                  selection: TextSelection.collapsed(
                                      offset: value.length),
                                );
                                formController.validateName(value);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                labelText: 'Please Enter your Name',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        formController.nameError.value.isEmpty
                                            ? Colors.black
                                            : Colors.red,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        formController.nameError.value.isEmpty
                                            ? Colors.black
                                            : Colors.red,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorText:
                                    formController.nameError.value.isEmpty
                                        ? null
                                        : formController.nameError.value,
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
                  //Email
                  Container(
                    width: Get.width * 0.95,
                    child: Column(
                      spacing: Get.height * 0.010,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email Id"),
                        Focus(
                          onFocusChange: (hasFocus) {
                            if (!hasFocus) {
                              formController.validateEmail(
                                  formController.emailId.value.text);
                            }
                          },
                          child: Obx(
                            () => TextFormField(
                              controller: formController.emailId.value,
                              onChanged: (value) {
                                formController.emailId.value.value =
                                    TextEditingValue(
                                  text: value,
                                  selection: TextSelection.collapsed(
                                      offset: value.length),
                                );
                                formController.validateEmail(value);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                labelText: 'Please Enter your Email Id',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: formController
                                            .emailIdError.value.isEmpty
                                        ? Colors.black
                                        : Colors.red,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: formController
                                            .emailIdError.value.isEmpty
                                        ? Colors.black
                                        : Colors.red,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorText:
                                    formController.emailIdError.value.isEmpty
                                        ? null
                                        : formController.emailIdError.value,
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
                  //phno
                  Container(
                    width: Get.width * 0.95,
                    child: Column(
                      spacing: Get.height * 0.010,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Phone Number"),
                        Focus(
                          onFocusChange: (hasFocus) {
                            if (!hasFocus) {
                              formController.validatePhoneNumber(
                                  formController.phoneNumber.value.text);
                            }
                          },
                          child: Obx(
                            () => TextFormField(
                              controller: formController.phoneNumber.value,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (value) {
                                formController.phoneNumber.value.value =
                                    TextEditingValue(
                                  text: value,
                                  selection: TextSelection.collapsed(
                                      offset: value.length),
                                );
                                formController.validatePhoneNumber(value);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                labelText: 'Please Enter your Phone Number',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: formController
                                            .phoneNumberError.value.isEmpty
                                        ? Colors.black
                                        : Colors.red,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: formController
                                            .phoneNumberError.value.isEmpty
                                        ? Colors.black
                                        : Colors.red,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorText: formController
                                        .phoneNumberError.value.isEmpty
                                    ? null
                                    : formController.phoneNumberError.value,
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
                  //UCID
                  Container(
                    width: Get.width * 0.95,
                    child: Column(
                      spacing: Get.height * 0.010,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("UCID"),
                        Focus(
                          onFocusChange: (hasFocus) {
                            if (!hasFocus) {
                              formController
                                  .validateUCID(formController.ucid.value.text);
                            }
                          },
                          child: Obx(
                            () => TextFormField(
                              controller: formController.ucid.value,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (value) {
                                formController.ucid.value.value =
                                    TextEditingValue(
                                  text: value,
                                  selection: TextSelection.collapsed(
                                      offset: value.length),
                                );
                                formController.validateUCID(value);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                labelText: 'Please Enter your UCID',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        formController.ucidError.value.isEmpty
                                            ? Colors.black
                                            : Colors.red,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        formController.ucidError.value.isEmpty
                                            ? Colors.black
                                            : Colors.red,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorText:
                                    formController.ucidError.value.isEmpty
                                        ? null
                                        : formController.ucidError.value,
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
                  SizedBox(
                    height: Get.height * 0.015,
                  )
                ],
              ),
            ),
            Divider(),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Get.height * 0.015,
                          horizontal: Get.width * 0.025),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "GRADUATION",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 20),
                      )),

                  //College
                  Container(
                    width: Get.width * 0.94,
                    child: Column(
                      spacing: Get.height * 0.010,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("College Name"),
                        Focus(
                          onFocusChange: (hasFocus) {
                            if (!hasFocus) {
                              formController.validateCollegeNameGraduation(
                                  formController
                                      .collegeNameGraduation.value.text);
                            }
                          },
                          child: Obx(
                            () => TextFormField(
                              controller:
                                  formController.collegeNameGraduation.value,
                              onChanged: (value) {
                                formController.collegeNameGraduation.value
                                    .value = TextEditingValue(
                                  text: value,
                                  selection: TextSelection.collapsed(
                                      offset: value.length),
                                );
                                formController
                                    .validateCollegeNameGraduation(value);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                labelText: 'Please Enter College Name',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: formController
                                            .collegeNameErrorGraduation
                                            .value
                                            .isEmpty
                                        ? Colors.black
                                        : Colors.red,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: formController
                                            .collegeNameErrorGraduation
                                            .value
                                            .isEmpty
                                        ? Colors.black
                                        : Colors.red,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorText: formController
                                        .collegeNameErrorGraduation
                                        .value
                                        .isEmpty
                                    ? null
                                    : formController
                                        .collegeNameErrorGraduation.value,
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //SEM1
                      Container(
                        width: Get.width * 0.45,
                        child: Column(
                          spacing: Get.height * 0.010,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("SEM1 CGPA"),
                            Focus(
                              onFocusChange: (hasFocus) {
                                if (!hasFocus) {
                                  formController.validateSem1(
                                      formController.sem1.value.text);
                                }
                              },
                              child: Obx(
                                () => TextFormField(
                                  controller: formController.sem1.value,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d*\.?\d*')),
                                  ],
                                  onChanged: (value) {
                                    formController.sem1.value.value =
                                        TextEditingValue(
                                      text: value,
                                      selection: TextSelection.collapsed(
                                          offset: value.length),
                                    );
                                    formController.validateTotalMarksHSC(value);
                                    formController.validateCGPA();
                                    formController
                                        .calculatePercentageGraduation();
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    labelText: 'Please Enter your SEM1 CGPA',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: formController
                                                .sem1Error.value.isEmpty
                                            ? Colors.black
                                            : Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: formController
                                                .sem1Error.value.isEmpty
                                            ? Colors.black
                                            : Colors.red,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorText:
                                        formController.sem1Error.value.isEmpty
                                            ? null
                                            : formController.sem1Error.value,
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
                      //SEM2
                      Container(
                        width: Get.width * 0.45,
                        child: Column(
                          spacing: Get.height * 0.010,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("SEM2 CGPA"),
                            Focus(
                              onFocusChange: (hasFocus) {
                                if (!hasFocus) {
                                  formController.validateSem2(
                                      formController.sem2.value.text);
                                }
                              },
                              child: Obx(
                                () => TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d*\.?\d*')),
                                  ],
                                  controller: formController.sem2.value,
                                  onChanged: (value) {
                                    formController.sem2.value.value =
                                        TextEditingValue(
                                      text: value,
                                      selection: TextSelection.collapsed(
                                          offset: value.length),
                                    );
                                    formController.validateSem2(value);
                                    formController.validateCGPA();
                                    formController
                                        .calculatePercentageGraduation();
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    labelText: 'Please Enter your SEM2 CGPA',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: formController
                                                .sem2Error.value.isEmpty
                                            ? Colors.black
                                            : Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: formController
                                                .sem2Error.value.isEmpty
                                            ? Colors.black
                                            : Colors.red,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorText:
                                        formController.sem2Error.value.isEmpty
                                            ? null
                                            : formController.sem2Error.value,
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //SEM3
                      Container(
                        width: Get.width * 0.45,
                        child: Column(
                          spacing: Get.height * 0.010,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("SEM3 CGPA"),
                            Focus(
                              onFocusChange: (hasFocus) {
                                if (!hasFocus) {
                                  formController.validateSem3(
                                      formController.sem3.value.text);
                                }
                              },
                              child: Obx(
                                () => TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d*\.?\d*')),
                                  ],
                                  controller: formController.sem3.value,
                                  onChanged: (value) {
                                    formController.sem3.value.value =
                                        TextEditingValue(
                                      text: value,
                                      selection: TextSelection.collapsed(
                                          offset: value.length),
                                    );
                                    formController.validateSem3(value);
                                    formController.validateCGPA();
                                    formController
                                        .calculatePercentageGraduation();
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    labelText: 'Please Enter your SEM3 CGPA',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: formController
                                                .sem3Error.value.isEmpty
                                            ? Colors.black
                                            : Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: formController
                                                .sem3Error.value.isEmpty
                                            ? Colors.black
                                            : Colors.red,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorText:
                                        formController.sem3Error.value.isEmpty
                                            ? null
                                            : formController.sem3Error.value,
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
                      //SEM4
                      Container(
                        width: Get.width * 0.45,
                        child: Column(
                          spacing: Get.height * 0.010,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("SEM4 CGPA"),
                            Focus(
                              onFocusChange: (hasFocus) {
                                if (!hasFocus) {
                                  formController.validateSem4(
                                      formController.sem4.value.text);
                                }
                              },
                              child: Obx(
                                () => TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d*\.?\d*')),
                                  ],
                                  controller: formController.sem4.value,
                                  onChanged: (value) {
                                    formController.sem4.value.value =
                                        TextEditingValue(
                                      text: value,
                                      selection: TextSelection.collapsed(
                                          offset: value.length),
                                    );
                                    formController.validateSem4(value);
                                    formController.validateCGPA();
                                    formController
                                        .calculatePercentageGraduation();
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    labelText: 'Please Enter your SEM4 CGPA',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: formController
                                                .sem4Error.value.isEmpty
                                            ? Colors.black
                                            : Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: formController
                                                .sem4Error.value.isEmpty
                                            ? Colors.black
                                            : Colors.red,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorText:
                                        formController.sem4Error.value.isEmpty
                                            ? null
                                            : formController.sem4Error.value,
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //SEM5
                      Container(
                        width: Get.width * 0.45,
                        child: Column(
                          spacing: Get.height * 0.010,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("SEM5 CGPA"),
                            Focus(
                              onFocusChange: (hasFocus) {
                                if (!hasFocus) {
                                  formController.validateSem5(
                                      formController.sem5.value.text);
                                }
                              },
                              child: Obx(
                                () => TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d*\.?\d*')),
                                  ],
                                  controller: formController.sem5.value,
                                  onChanged: (value) {
                                    formController.sem5.value.value =
                                        TextEditingValue(
                                      text: value,
                                      selection: TextSelection.collapsed(
                                          offset: value.length),
                                    );
                                    formController.validateSem5(value);
                                    formController.validateCGPA();
                                    formController
                                        .calculatePercentageGraduation();
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    labelText: 'Please Enter your SEM5 CGPA',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: formController
                                                .sem5Error.value.isEmpty
                                            ? Colors.black
                                            : Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: formController
                                                .sem5Error.value.isEmpty
                                            ? Colors.black
                                            : Colors.red,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorText:
                                        formController.sem5Error.value.isEmpty
                                            ? null
                                            : formController.sem5Error.value,
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
                      //SEM6
                      Container(
                        width: Get.width * 0.45,
                        child: Column(
                          spacing: Get.height * 0.010,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("SEM6 CGPA"),
                            Focus(
                              onFocusChange: (hasFocus) {
                                if (!hasFocus) {
                                  formController.validateSem6(
                                      formController.sem6.value.text);
                                }
                              },
                              child: Obx(
                                () => TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d*\.?\d*')),
                                  ],
                                  controller: formController.sem6.value,
                                  onChanged: (value) {
                                    formController.sem6.value.value =
                                        TextEditingValue(
                                      text: value,
                                      selection: TextSelection.collapsed(
                                          offset: value.length),
                                    );
                                    formController.validateSem6(value);
                                    formController.validateCGPA();
                                    formController
                                        .calculatePercentageGraduation();
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    labelText: 'Please Enter your SEM6 CGPA',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: formController
                                                .sem6Error.value.isEmpty
                                            ? Colors.black
                                            : Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: formController
                                                .sem6Error.value.isEmpty
                                            ? Colors.black
                                            : Colors.red,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorText:
                                        formController.sem6Error.value.isEmpty
                                            ? null
                                            : formController.sem6Error.value,
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //CGPA
                      Container(
                        width: Get.width * 0.45,
                        child: Column(
                          spacing: Get.height * 0.010,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("CGPA"),
                            Obx(
                              () => TextFormField(
                                readOnly: true,
                                controller: formController.CGPA.value,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d*')),
                                ],

                                decoration: InputDecoration(
                                  hintText: 'Your CGPA',
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:  Colors.black,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:Colors.black,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),

                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //percentage
                      Container(
                        width: Get.width * 0.45,
                        child: Column(
                          spacing: Get.height * 0.010,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Percentage"),
                            Obx(
                              () => TextFormField(
                                readOnly: true,
                                controller:
                                    formController.percentageGraduation.value,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d*')),
                                ],

                                decoration: InputDecoration(
                                  hintText: 'Your Percentage',
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),

                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  )
                ],
              ),
            ),
            Divider(),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Get.height * 0.015,
                          horizontal: Get.width * 0.025),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "HSC",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 20),
                      )),

                  //College
                  Container(
                    width: Get.width * 0.94,
                    child: Column(
                      spacing: Get.height * 0.010,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("College Name"),
                        Focus(
                          onFocusChange: (hasFocus) {
                            if (!hasFocus) {
                              formController.validateCollegeNameHSC(
                                  formController.collegeNameHSC.value.text);
                            }
                          },
                          child: Obx(
                            () => TextFormField(
                              controller: formController.collegeNameHSC.value,
                              onChanged: (value) {
                                formController.collegeNameHSC.value.value =
                                    TextEditingValue(
                                  text: value,
                                  selection: TextSelection.collapsed(
                                      offset: value.length),
                                );
                                formController.validateCollegeNameHSC(value);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                labelText: 'Please Enter College Name',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: formController
                                            .collegeNameErrorHSC.value.isEmpty
                                        ? Colors.black
                                        : Colors.red,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: formController
                                            .collegeNameErrorHSC.value.isEmpty
                                        ? Colors.black
                                        : Colors.red,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorText: formController
                                        .collegeNameErrorHSC.value.isEmpty
                                    ? null
                                    : formController.collegeNameErrorHSC.value,
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
                  //Year of passing
                  Container(
                    width: Get.width * 0.94,
                    child: Column(
                      spacing: Get.height * 0.010,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Year of Passing"),
                        Focus(
                          onFocusChange: (hasFocus) {
                            if (!hasFocus) {
                              formController.validateYearOfPassingHSC(
                                  formController.yearOfPassingHSC.value.text);
                            }
                          },
                          child: Obx(
                            () => TextFormField(
                              controller: formController.yearOfPassingHSC.value,
                              onChanged: (value) {
                                formController.yearOfPassingHSC.value.value =
                                    TextEditingValue(
                                  text: value,
                                  selection: TextSelection.collapsed(
                                      offset: value.length),
                                );
                                formController.validateYearOfPassingHSC(value);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                labelText: 'Please Enter Year of Passing',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: formController
                                            .yearOfPassingErrorHSC.value.isEmpty
                                        ? Colors.black
                                        : Colors.red,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: formController
                                            .yearOfPassingErrorHSC.value.isEmpty
                                        ? Colors.black
                                        : Colors.red,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorText: formController
                                        .yearOfPassingErrorHSC.value.isEmpty
                                    ? null
                                    : formController
                                        .yearOfPassingErrorHSC.value,
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //marks obtained
                      Container(
                        width: Get.width * 0.45,
                        child: Column(
                          spacing: Get.height * 0.010,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Marks Obtained"),
                            Focus(
                              onFocusChange: (hasFocus) {
                                if (!hasFocus) {
                                  formController.validateMarksObtainedHSC(
                                      formController
                                          .marksObtainedHSC.value.text);
                                  formController.calculatePercentageHSC();
                                }
                              },
                              child: Obx(
                                () => TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  controller:
                                      formController.marksObtainedHSC.value,
                                  onChanged: (value) {
                                    formController.marksObtainedHSC.value
                                        .value = TextEditingValue(
                                      text: value,
                                      selection: TextSelection.collapsed(
                                          offset: value.length),
                                    );
                                    formController
                                        .validateMarksObtainedHSC(value);
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    labelText: 'Please Enter Marks Obtained',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: formController
                                                .marksObtainedErrorHSC
                                                .value
                                                .isEmpty
                                            ? Colors.black
                                            : Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: formController
                                                .marksObtainedErrorHSC
                                                .value
                                                .isEmpty
                                            ? Colors.black
                                            : Colors.red,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorText: formController
                                            .marksObtainedErrorHSC.value.isEmpty
                                        ? null
                                        : formController
                                            .marksObtainedErrorHSC.value,
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
                      //Total Marks
                      Container(
                        width: Get.width * 0.45,
                        child: Column(
                          spacing: Get.height * 0.010,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total Marks"),
                            Focus(
                              onFocusChange: (hasFocus) {
                                if (!hasFocus) {
                                  formController.validateTotalMarksHSC(
                                      formController.totalMarksHSC.value.text);
                                  formController.calculatePercentageHSC();
                                }
                              },
                              child: Obx(
                                () => TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  controller:
                                      formController.totalMarksHSC.value,
                                  onChanged: (value) {
                                    formController.totalMarksHSC.value.value =
                                        TextEditingValue(
                                      text: value,
                                      selection: TextSelection.collapsed(
                                          offset: value.length),
                                    );
                                    formController.validateTotalMarksHSC(value);
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    labelText: 'Please Enter your Total Marks',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: formController.totalMarksErrorHSC
                                                .value.isEmpty
                                            ? Colors.black
                                            : Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: formController.totalMarksErrorHSC
                                                .value.isEmpty
                                            ? Colors.black
                                            : Colors.red,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorText: formController
                                            .totalMarksErrorHSC.value.isEmpty
                                        ? null
                                        : formController
                                            .totalMarksErrorHSC.value,
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

                  //Percentage
                  Container(
                    width: Get.width * 0.94,
                    child: Column(
                      spacing: Get.height * 0.010,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Percentage"),
                        Obx(
                          () => TextFormField(
                            readOnly: true,
                            controller: formController.percentageHSC.value,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value) {
                              formController.percentageHSC.value.value =
                                  TextEditingValue(
                                text: value,
                                selection: TextSelection.collapsed(
                                    offset: value.length),
                              );
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              labelText: 'Your Percentage',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: formController
                                          .percentageErrorHSC.value.isEmpty
                                      ? Colors.black
                                      : Colors.red,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: formController
                                          .percentageErrorHSC.value.isEmpty
                                      ? Colors.black
                                      : Colors.red,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorText: formController
                                      .percentageErrorHSC.value.isEmpty
                                  ? null
                                  : formController.percentageErrorHSC.value,
                              errorStyle: TextStyle(color: Colors.red),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  )
                ],
              ),
            ),
            Divider(),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Get.height * 0.015,
                        horizontal: Get.width * 0.025),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "SSC",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                  ),

                  //College
                  Container(
                    width: Get.width * 0.94,
                    child: Column(
                      spacing: Get.height * 0.010,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("School Name"),
                        Focus(
                          onFocusChange: (hasFocus) {
                            if (!hasFocus) {
                              formController.validateCollegeNameSSC(
                                  formController.collegeNameSSC.value.text);
                            }
                          },
                          child: Obx(
                            () => TextFormField(
                              controller: formController.collegeNameSSC.value,
                              onChanged: (value) {
                                formController.collegeNameSSC.value.value =
                                    TextEditingValue(
                                  text: value,
                                  selection: TextSelection.collapsed(
                                      offset: value.length),
                                );
                                formController.validateCollegeNameSSC(value);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                labelText: 'Please Enter College Name',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: formController
                                            .collegeNameErrorSSC.value.isEmpty
                                        ? Colors.black
                                        : Colors.red,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: formController
                                            .collegeNameErrorSSC.value.isEmpty
                                        ? Colors.black
                                        : Colors.red,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorText: formController
                                        .collegeNameErrorSSC.value.isEmpty
                                    ? null
                                    : formController.collegeNameErrorSSC.value,
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
                  //Year of passing
                  Container(
                    width: Get.width * 0.94,
                    child: Column(
                      spacing: Get.height * 0.010,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Year of Passing"),
                        Focus(
                          onFocusChange: (hasFocus) {
                            if (!hasFocus) {
                              formController.validateYearOfPassingSSC(
                                  formController.yearOfPassingSSC.value.text);
                            }
                          },
                          child: Obx(
                            () => TextFormField(
                              controller: formController.yearOfPassingSSC.value,
                              onChanged: (value) {
                                formController.yearOfPassingSSC.value.value =
                                    TextEditingValue(
                                  text: value,
                                  selection: TextSelection.collapsed(
                                      offset: value.length),
                                );
                                formController.validateYearOfPassingSSC(value);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                labelText: 'Please Enter Year of Passing',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: formController
                                            .yearOfPassingErrorSSC.value.isEmpty
                                        ? Colors.black
                                        : Colors.red,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: formController
                                            .yearOfPassingErrorSSC.value.isEmpty
                                        ? Colors.black
                                        : Colors.red,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorText: formController
                                        .yearOfPassingErrorSSC.value.isEmpty
                                    ? null
                                    : formController
                                        .yearOfPassingErrorSSC.value,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //marks obtained
                      Container(
                        width: Get.width * 0.45,
                        child: Column(
                          spacing: Get.height * 0.010,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Marks Obtained"),
                            Focus(
                              onFocusChange: (hasFocus) {
                                if (!hasFocus) {
                                  formController.validateMarksObtainedSSC(
                                      formController
                                          .marksObtainedSSC.value.text);
                                }
                              },
                              child: Obx(
                                () => TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  controller:
                                      formController.marksObtainedSSC.value,
                                  onChanged: (value) {
                                    formController.marksObtainedSSC.value
                                        .value = TextEditingValue(
                                      text: value,
                                      selection: TextSelection.collapsed(
                                          offset: value.length),
                                    );
                                    formController
                                        .validateMarksObtainedSSC(value);
                                    formController.calculatePercentageSSC();
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    labelText: 'Please Enter Marks Obtained',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: formController
                                                .marksObtainedErrorSSC
                                                .value
                                                .isEmpty
                                            ? Colors.black
                                            : Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: formController
                                                .marksObtainedErrorSSC
                                                .value
                                                .isEmpty
                                            ? Colors.black
                                            : Colors.red,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorText: formController
                                            .marksObtainedErrorSSC.value.isEmpty
                                        ? null
                                        : formController
                                            .marksObtainedErrorSSC.value,
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
                      //Total Marks
                      Container(
                        width: Get.width * 0.45,
                        child: Column(
                          spacing: Get.height * 0.010,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total Marks"),
                            Focus(
                              onFocusChange: (hasFocus) {
                                if (!hasFocus) {
                                  formController.validateTotalMarksSSC(
                                      formController.totalMarksSSC.value.text);
                                }
                              },
                              child: Obx(
                                () => TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  controller:
                                      formController.totalMarksSSC.value,
                                  onChanged: (value) {
                                    formController.totalMarksSSC.value.value =
                                        TextEditingValue(
                                      text: value,
                                      selection: TextSelection.collapsed(
                                          offset: value.length),
                                    );
                                    formController.validateTotalMarksSSC(value);
                                    formController.calculatePercentageSSC();
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    labelText: 'Please Enter your Total Marks',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: formController.totalMarksErrorSSC
                                                .value.isEmpty
                                            ? Colors.black
                                            : Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: formController.totalMarksErrorSSC
                                                .value.isEmpty
                                            ? Colors.black
                                            : Colors.red,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorText: formController
                                            .totalMarksErrorSSC.value.isEmpty
                                        ? null
                                        : formController
                                            .totalMarksErrorSSC.value,
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

                  //Percentage
                  Container(
                    width: Get.width * 0.94,
                    child: Column(
                      spacing: Get.height * 0.010,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Percentage"),
                        Obx(
                          () => TextFormField(
                            readOnly: true,
                            controller: formController.percentageSSC.value,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value) {
                              formController.phoneNumber.value.value =
                                  TextEditingValue(
                                text: value,
                                selection: TextSelection.collapsed(
                                    offset: value.length),
                              );
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              labelText: 'Your Percentage',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: formController
                                          .percentageErrorSSC.value.isEmpty
                                      ? Colors.black
                                      : Colors.red,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: formController
                                          .percentageErrorSSC.value.isEmpty
                                      ? Colors.black
                                      : Colors.red,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorText: formController
                                      .percentageErrorSSC.value.isEmpty
                                  ? null
                                  : formController.percentageErrorSSC.value,
                              errorStyle: TextStyle(color: Colors.red),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: Get.height * 0.015,
                  )
                ],
              ),
            ),
            Divider(),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Get.height * 0.015,
                            horizontal: Get.width * 0.025),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Your Image",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 20),
                        ),
                      )),
                  SizedBox(height: Get.height * 0.02),
                  GestureDetector(
                    onTap: () {
                      formController.pickProfileImage();
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: Get.width * 0.92,
                      height: Get.height * 0.04,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xff1976D2),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        "Pick Image",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Obx(() {
                    if (formController.profileImagePath.value != null) {
                      return CircleAvatar(
                        radius: 100,
                        backgroundImage: FileImage(
                            File(formController.profileImagePath.value)),
                      );
                    } else {
                      return Text("No profile image selected.");
                    }
                  }),
                ],
              ),
            ),
            Divider(),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Get.height * 0.015,
                            horizontal: Get.width * 0.025),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Your Resume",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 20),
                        ),
                      )),
                  SizedBox(height: Get.height * 0.02),
                  GestureDetector(
                    onTap: () {
                      formController.pickFile();
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: Get.width * 0.92,
                      height: Get.height * 0.04,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xff1976D2),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        "Pick Resume",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Obx(() {
                    if (formController.selectedFilePath.isNotEmpty) {
                      return formController.isPdf.value
                          ? Container(
                              height: Get.height * 0.5,
                              child: PDFView(
                                  filePath:
                                      formController.selectedFilePath.value),
                            )
                          : Image.file(
                              File(formController.selectedFilePath.value),
                              height: Get.height * 0.3,
                              fit: BoxFit.cover,
                            );
                    }
                    return Container();
                  }),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (formController.isFormValid()) {
                  print('Valid');
                  formController.storeFormValues();
                  formController.resetForm();
                  Get.snackbar(
                    "Registered",
                    "You are Registered Successfully",
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.green,
                  );
                  Get.off(MainScreen());
                } else {
                  print('InValid');
                  Get.snackbar(
                    "Form Error",
                    "Please fill in all the required fields correctly.",
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.red,
                  );
                }
              },
              child: Container(
                margin: EdgeInsets.all(10),
                width: Get.width * 0.92,
                height: Get.height * 0.04,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xff1976D2),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
