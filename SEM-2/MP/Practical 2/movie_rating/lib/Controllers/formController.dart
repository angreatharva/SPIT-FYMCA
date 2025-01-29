
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FormController extends GetxController {
  // Rx variables for each field
  var name = ''.obs;
  var surname = ''.obs;
  var dob = ''.obs;
  var emailId = ''.obs;
  var phoneNumber = ''.obs;
  var address = ''.obs;
  var review = ''.obs;
  var rating = 0.0.obs;
  var selectedGender = 'Male'.obs;

  // Validation states
  var nameError = ''.obs;
  var surnameError = ''.obs;
  var emailIdError = ''.obs;
  var phoneNumberError = ''.obs;
  var dobError = ''.obs;
  var addressError = ''.obs;
  var reviewError = ''.obs;

  // Validation logic
  void validateName(String value) {
    if (value.isEmpty) {
      nameError.value = 'Name is required';
    } else {
      nameError.value = '';
    }
  }

  void validateSurname(String value) {
    if (value.isEmpty) {
      surnameError.value = 'Surname is required';
    } else {
      surnameError.value = '';
    }
  }

  void validateEmail(String value) {
    if (value.isEmpty) {
      emailIdError.value = 'Email is required';
    } else if (!GetUtils.isEmail(value)) {
      emailIdError.value = 'Invalid email';
    } else {
      emailIdError.value = '';
    }
  }

  void validatePhoneNumber(String value) {
    if (value.isEmpty) {
      phoneNumberError.value = 'Phone number is required';
    } else if (value.length != 10) {
      phoneNumberError.value = 'Phone number must be 10 digits';
    } else {
      phoneNumberError.value = '';
    }
  }

  void validateAddress(String value) {
    if (value.isEmpty) {
      addressError.value = 'Address is required';
    } else {
      addressError.value = '';
    }
  }

  void validateReview(String value) {
    if (value.isEmpty) {
      reviewError.value = 'Review is required';
    } else {
      reviewError.value = '';
    }
  }
}