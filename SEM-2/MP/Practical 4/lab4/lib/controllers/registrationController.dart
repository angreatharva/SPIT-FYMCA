import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FormController extends GetxController {

  final box = GetStorage();

  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> emailId = TextEditingController().obs;
  Rx<TextEditingController> phoneNumber = TextEditingController().obs;
  Rx<TextEditingController> ucid = TextEditingController().obs;

  Rx<TextEditingController> marksObtained = TextEditingController().obs;
  Rx<TextEditingController> totalMarks = TextEditingController().obs;
  Rx<TextEditingController> percentage = TextEditingController().obs;




  var nameError = ''.obs;
  var emailIdError = ''.obs;
  var phoneNumberError = ''.obs;
  var ucidError = ''.obs;

  var marksObtainedError = ''.obs;
  var totalMarksError = ''.obs;
  var percentageError = ''.obs;


  void validateName(String value) {
    if (value.isEmpty) {
      nameError.value = 'Name is required';
    } else if (value.length < 2) {
      nameError.value = 'Name must be at least 2 characters';
    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      nameError.value = 'Name can only contain letters';
    } else {
      nameError.value = '';
    }
  }

  void validateEmail(String value) {
    if (value.isEmpty) {
      emailIdError.value = 'Email is required';
    } else if (!GetUtils.isEmail(value)) {
      emailIdError.value = 'Please enter a valid email address';
    } else {
      emailIdError.value = '';
    }
  }

  void validatePhoneNumber(String value) {
    if (value.isEmpty) {
      phoneNumberError.value = 'Phone number is required';
    } else if (value.length != 10) {
      phoneNumberError.value = 'Phone number must be exactly 10 digits';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      phoneNumberError.value = 'Phone number can only contain digits';
    } else {
      phoneNumberError.value = '';
    }
  }

  void validateUCID(String value) {
    if (value.isEmpty) {
      ucidError.value = 'UCID is required';
    } else if (value.length != 10) {
      ucidError.value = 'UCID must be exactly 10 digits';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      ucidError.value = 'UCID can only contain digits';
    } else {
      ucidError.value = '';
    }
  }

  void validateMarksObtained(String value) {
    if (value.isEmpty) {
      marksObtainedError.value = 'Marks Obtained is required';
    }else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      marksObtainedError.value = 'Marks Obtained can only contain digits';
    } else {
      marksObtainedError.value = '';
    }
  }

  void validateTotalMarks(String value) {
    if (value.isEmpty) {
      totalMarksError.value = 'Total Marks is required';
    }else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      totalMarksError.value = 'Total Marks can only contain digits';
    } else {
      totalMarksError.value = '';
    }
  }


  void calculatePercentage(String value) {

  }



  void validateAllFields() {
    validateName(name.value.text);
    validateEmail(emailId.value.text);
    validatePhoneNumber(phoneNumber.value.text);

  }

  bool isFormValid() {
    return nameError.value.isEmpty &&
        emailIdError.value.isEmpty &&
        phoneNumberError.value.isEmpty &&
        ucidError.value.isEmpty &&
        marksObtainedError.value.isEmpty &&
        totalMarksError.value.isEmpty &&
        percentageError.value.isEmpty &&


        name.value.text.isNotEmpty &&
        emailId.value.text.isNotEmpty &&
        phoneNumber.value.text.isNotEmpty &&
        ucid.value.text.isNotEmpty &&
        marksObtained.value.text.isNotEmpty &&
        totalMarks.value.text.isNotEmpty &&
        percentage.value.text.isNotEmpty
    ;
  }

  void resetForm() {
    name.value.text = '';
    emailId.value.text = '';
    phoneNumber.value.text = '';
    ucid.value.text = '';
    marksObtained.value.text = '';
    totalMarks.value.text = '';
    percentage.value.text = '';



    nameError.value = '';
    emailIdError.value = '';
    phoneNumberError.value = '';
    ucidError.value = '';
    marksObtainedError.value = '';
    totalMarksError.value = '';
    percentageError.value = '';

  }
}