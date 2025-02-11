import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
        title: Text("Register",style: TextStyle(color: Colors.white),),
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
                      padding:EdgeInsets.symmetric(vertical: Get.height * 0.015 ),
                      child: Text("Details About you",style: TextStyle(fontWeight: FontWeight.w800,fontSize:20),)),
        
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
                              formController.validateUCID(formController.ucid.value.text);
                            }
                          },
                          child: Obx(()=>
                              TextFormField(
                                controller:  formController.ucid.value,
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                onChanged: (value) {
                                  formController.ucid.value.value = TextEditingValue(
                                    text: value,
                                    selection: TextSelection.collapsed(offset: value.length),
                                  );
                                  formController.validateUCID(value);
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  labelText: 'Please Enter your UCID',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: formController.ucidError.value.isEmpty ? Colors.black : Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: formController.ucidError.value.isEmpty ? Colors.black : Colors.red,
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
                                  errorText: formController.ucidError.value.isEmpty ? null : formController.ucidError.value,
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
            ),
            Divider(),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Container(
                      padding:EdgeInsets.symmetric(vertical: Get.height * 0.015 ),
                      child: Text("SSC Score",style: TextStyle(fontWeight: FontWeight.w800,fontSize:20),)),
        
                  //marks obtained
                  Container(
                    width: Get.width * 0.95,
                    child: Column(
                      spacing: Get.height * 0.010,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Marks Obtained"),
                        Focus(
                          onFocusChange: (hasFocus) {
                            if (!hasFocus) {
                              formController.validateMarksObtained(formController.marksObtained.value.text);
                            }
                          },
                          child: Obx(()=>
                              TextFormField(
                                controller: formController.marksObtained.value,
                                onChanged: (value) {
                                  formController.marksObtained.value.value = TextEditingValue(
                                    text: value,
                                    selection: TextSelection.collapsed(offset: value.length),
                                  );
                                  formController.validateMarksObtained(value);
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  labelText: 'Please Enter Marks Obtained',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: formController.marksObtainedError.value.isEmpty ? Colors.black : Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: formController.marksObtainedError.value.isEmpty ? Colors.black : Colors.red,
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
                                  errorText: formController.marksObtainedError.value.isEmpty ? null : formController.marksObtainedError.value,
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
                    width: Get.width * 0.95,
                    child: Column(
                      spacing: Get.height * 0.010,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total Marks"),
                        Focus(
                          onFocusChange: (hasFocus) {
                            if (!hasFocus) {
                              formController.validateTotalMarks(formController.totalMarks.value.text);
                            }
                          },
                          child: Obx(()=>
                              TextFormField(
                                controller:  formController.totalMarks.value,
                                onChanged: (value) {
                                  formController.totalMarks.value.value = TextEditingValue(
                                    text: value,
                                    selection: TextSelection.collapsed(offset: value.length),
                                  );
                                  formController.validateTotalMarks(value);
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  labelText: 'Please Enter your Total Marks',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: formController.totalMarksError.value.isEmpty ? Colors.black : Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: formController.totalMarksError.value.isEmpty ? Colors.black : Colors.red,
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
                                  errorText: formController.totalMarksError.value.isEmpty ? null : formController.totalMarksError.value,
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
                  //Percentage
                  Container(
                    width: Get.width * 0.95,
                    child: Column(
                      spacing: Get.height * 0.010,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Percentage"),
                        Focus(
                          onFocusChange: (hasFocus) {
                            if (!hasFocus) {
                              formController.validatePhoneNumber(formController.phoneNumber.value.text);
                            }
                          },
                          child: Obx(()=>
                              TextFormField(
                                readOnly: true,
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
                                  labelText: 'Please Enter your Percentage',
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
                  ),
                 
                ],
              ),
            ),
            Divider(),
            // Container(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     spacing: 10,
            //     children: [
            //       Container(
            //           padding:EdgeInsets.symmetric(vertical: Get.height * 0.015 ),
            //           child: Text("HSC Score",style: TextStyle(fontWeight: FontWeight.w800,fontSize:20),)),
            //
            //       //Name
            //       Container(
            //         width: Get.width * 0.95,
            //         child: Column(
            //           spacing: Get.height * 0.010,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text("Name"),
            //             Focus(
            //               onFocusChange: (hasFocus) {
            //                 if (!hasFocus) {
            //                   formController.validateName(formController.name.value.text);
            //                 }
            //               },
            //               child: Obx(()=>
            //                   TextFormField(
            //                     controller: formController.name.value,
            //                     onChanged: (value) {
            //                       formController.name.value.value = TextEditingValue(
            //                         text: value,
            //                         selection: TextSelection.collapsed(offset: value.length),
            //                       );
            //                       formController.validateName(value);
            //                     },
            //                     decoration: InputDecoration(
            //                       contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            //                       labelText: 'Please Enter your Name',
            //                       enabledBorder: OutlineInputBorder(
            //                         borderSide: BorderSide(
            //                           color: formController.nameError.value.isEmpty ? Colors.black : Colors.red,
            //                           width: 2,
            //                         ),
            //                         borderRadius: BorderRadius.circular(8),
            //                       ),
            //                       focusedBorder: OutlineInputBorder(
            //                         borderSide: BorderSide(
            //                           color: formController.nameError.value.isEmpty ? Colors.black : Colors.red,
            //                           width: 1.5,
            //                         ),
            //                         borderRadius: BorderRadius.circular(8),
            //                       ),
            //                       errorBorder: OutlineInputBorder(
            //                         borderSide: BorderSide(color: Colors.red, width: 1.5),
            //                         borderRadius: BorderRadius.circular(8),
            //                       ),
            //                       focusedErrorBorder: OutlineInputBorder(
            //                         borderSide: BorderSide(color: Colors.red, width: 1.5),
            //                         borderRadius: BorderRadius.circular(8),
            //                       ),
            //                       errorText: formController.nameError.value.isEmpty ? null : formController.nameError.value,
            //                       errorStyle: TextStyle(color: Colors.red),
            //                       filled: true,
            //                       fillColor: Colors.white,
            //                     ),
            //                   ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       //Email
            //       Container(
            //         width: Get.width * 0.95,
            //         child: Column(
            //           spacing: Get.height * 0.010,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text("Email Id"),
            //             Focus(
            //               onFocusChange: (hasFocus) {
            //                 if (!hasFocus) {
            //                   formController.validateEmail(formController.emailId.value.text);
            //                 }
            //               },
            //               child: Obx(()=>
            //                   TextFormField(
            //                     controller:  formController.emailId.value,
            //                     onChanged: (value) {
            //                       formController.emailId.value.value = TextEditingValue(
            //                         text: value,
            //                         selection: TextSelection.collapsed(offset: value.length),
            //                       );
            //                       formController.validateEmail(value);
            //                     },
            //                     decoration: InputDecoration(
            //                       contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            //                       labelText: 'Please Enter your Email Id',
            //                       enabledBorder: OutlineInputBorder(
            //                         borderSide: BorderSide(
            //                           color: formController.emailIdError.value.isEmpty ? Colors.black : Colors.red,
            //                           width: 2,
            //                         ),
            //                         borderRadius: BorderRadius.circular(8),
            //                       ),
            //                       focusedBorder: OutlineInputBorder(
            //                         borderSide: BorderSide(
            //                           color: formController.emailIdError.value.isEmpty ? Colors.black : Colors.red,
            //                           width: 1.5,
            //                         ),
            //                         borderRadius: BorderRadius.circular(8),
            //                       ),
            //                       errorBorder: OutlineInputBorder(
            //                         borderSide: BorderSide(color: Colors.red, width: 1.5),
            //                         borderRadius: BorderRadius.circular(8),
            //                       ),
            //                       focusedErrorBorder: OutlineInputBorder(
            //                         borderSide: BorderSide(color: Colors.red, width: 1.5),
            //                         borderRadius: BorderRadius.circular(8),
            //                       ),
            //                       errorText: formController.emailIdError.value.isEmpty ? null : formController.emailIdError.value,
            //                       errorStyle: TextStyle(color: Colors.red),
            //                       filled: true,
            //                       fillColor: Colors.white,
            //                     ),
            //                   ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       //phno
            //       Container(
            //         width: Get.width * 0.95,
            //         child: Column(
            //           spacing: Get.height * 0.010,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text("Phone Number"),
            //             Focus(
            //               onFocusChange: (hasFocus) {
            //                 if (!hasFocus) {
            //                   formController.validatePhoneNumber(formController.phoneNumber.value.text);
            //                 }
            //               },
            //               child: Obx(()=>
            //                   TextFormField(
            //                     controller:  formController.phoneNumber.value,
            //                     keyboardType: TextInputType.number,
            //                     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            //                     onChanged: (value) {
            //                       formController.phoneNumber.value.value = TextEditingValue(
            //                         text: value,
            //                         selection: TextSelection.collapsed(offset: value.length),
            //                       );
            //                       formController.validatePhoneNumber(value);
            //                     },
            //                     decoration: InputDecoration(
            //                       contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            //                       labelText: 'Please Enter your Phone Number',
            //                       enabledBorder: OutlineInputBorder(
            //                         borderSide: BorderSide(
            //                           color: formController.phoneNumberError.value.isEmpty ? Colors.black : Colors.red,
            //                           width: 2,
            //                         ),
            //                         borderRadius: BorderRadius.circular(8),
            //                       ),
            //                       focusedBorder: OutlineInputBorder(
            //                         borderSide: BorderSide(
            //                           color: formController.phoneNumberError.value.isEmpty ? Colors.black : Colors.red,
            //                           width: 1.5,
            //                         ),
            //                         borderRadius: BorderRadius.circular(8),
            //                       ),
            //                       errorBorder: OutlineInputBorder(
            //                         borderSide: BorderSide(color: Colors.red, width: 1.5),
            //                         borderRadius: BorderRadius.circular(8),
            //                       ),
            //                       focusedErrorBorder: OutlineInputBorder(
            //                         borderSide: BorderSide(color: Colors.red, width: 1.5),
            //                         borderRadius: BorderRadius.circular(8),
            //                       ),
            //                       errorText: formController.phoneNumberError.value.isEmpty ? null : formController.phoneNumberError.value,
            //                       errorStyle: TextStyle(color: Colors.red),
            //                       filled: true,
            //                       fillColor: Colors.white,
            //                     ),
            //                   ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       //UCID
            //       Container(
            //         width: Get.width * 0.95,
            //         child: Column(
            //           spacing: Get.height * 0.010,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text("UCID"),
            //             Focus(
            //               onFocusChange: (hasFocus) {
            //                 if (!hasFocus) {
            //                   formController.validateUCID(formController.ucid.value.text);
            //                 }
            //               },
            //               child: Obx(()=>
            //                   TextFormField(
            //                     controller:  formController.ucid.value,
            //                     keyboardType: TextInputType.number,
            //                     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            //                     onChanged: (value) {
            //                       formController.ucid.value.value = TextEditingValue(
            //                         text: value,
            //                         selection: TextSelection.collapsed(offset: value.length),
            //                       );
            //                       formController.validateUCID(value);
            //                     },
            //                     decoration: InputDecoration(
            //                       contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            //                       labelText: 'Please Enter your UCID',
            //                       enabledBorder: OutlineInputBorder(
            //                         borderSide: BorderSide(
            //                           color: formController.ucidError.value.isEmpty ? Colors.black : Colors.red,
            //                           width: 2,
            //                         ),
            //                         borderRadius: BorderRadius.circular(8),
            //                       ),
            //                       focusedBorder: OutlineInputBorder(
            //                         borderSide: BorderSide(
            //                           color: formController.ucidError.value.isEmpty ? Colors.black : Colors.red,
            //                           width: 1.5,
            //                         ),
            //                         borderRadius: BorderRadius.circular(8),
            //                       ),
            //                       errorBorder: OutlineInputBorder(
            //                         borderSide: BorderSide(color: Colors.red, width: 1.5),
            //                         borderRadius: BorderRadius.circular(8),
            //                       ),
            //                       focusedErrorBorder: OutlineInputBorder(
            //                         borderSide: BorderSide(color: Colors.red, width: 1.5),
            //                         borderRadius: BorderRadius.circular(8),
            //                       ),
            //                       errorText: formController.ucidError.value.isEmpty ? null : formController.ucidError.value,
            //                       errorStyle: TextStyle(color: Colors.red),
            //                       filled: true,
            //                       fillColor: Colors.white,
            //                     ),
            //                   ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
