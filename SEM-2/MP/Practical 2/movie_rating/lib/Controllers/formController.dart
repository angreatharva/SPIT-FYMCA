import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

class FormController extends GetxController {

  final box = GetStorage();

  // var name = ''.obs;
  // var surname = ''.obs;
  // var dob = ''.obs;
  // var emailId = ''.obs;
  // var phoneNumber = ''.obs;
  // var address = ''.obs;
  // var review = ''.obs;
  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> surname = TextEditingController().obs;
  Rx<TextEditingController> dob = TextEditingController().obs;
  Rx<TextEditingController> emailId = TextEditingController().obs;
  Rx<TextEditingController> phoneNumber = TextEditingController().obs;
  Rx<TextEditingController> address = TextEditingController().obs;
  Rx<TextEditingController> review = TextEditingController().obs;
  Rx<TextEditingController> movieName = TextEditingController().obs;

  var rating = 0.0.obs;
  var ratingError = ''.obs;
  var selectedGender = 'Male'.obs;

  var nameError = ''.obs;
  var surnameError = ''.obs;
  var emailIdError = ''.obs;
  var phoneNumberError = ''.obs;
  var dobError = ''.obs;
  var addressError = ''.obs;
  var reviewError = ''.obs;
  var movieNameError = ''.obs;

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

  void validateSurname(String value) {
    if (value.isEmpty) {
      surnameError.value = 'Surname is required';
    } else if (value.length < 2) {
      surnameError.value = 'Surname must be at least 2 characters';
    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      surnameError.value = 'Surname can only contain letters';
    } else {
      surnameError.value = '';
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

  void validateDob(String value) {
    if (value.isEmpty) {
      dobError.value = 'Date of birth is required';
    } else {
      dobError.value = '';
    }
  }

  void validateAddress(String value) {
    if (value.isEmpty) {
      addressError.value = 'Address is required';
    } else if (value.length < 10) {
      addressError.value = 'Please enter a complete address';
    } else {
      addressError.value = '';
    }
  }

  void validateReview(String value) {
    if (value.isEmpty) {
      reviewError.value = 'Review is required';
    }  else {
      reviewError.value = '';
    }
  }

  void validateMovieName(String value) {
    if (value.isEmpty) {
      movieNameError.value = 'Movie Name is required';
    }
    else{
      movieNameError.value = '';
    }
  }

  void validateRating(double rating) {
    if (rating == 0) {
      ratingError.value = 'Rating is required';
    } else {
      ratingError.value = '';
    }
  }


  void validateAllFields() {
    validateName(name.value.text);
    validateSurname(surname.value.text);
    validateEmail(emailId.value.text);
    validatePhoneNumber(phoneNumber.value.text);
    validateDob(dob.value.text);
    validateMovieName(movieName.value.text);
    validateAddress(address.value.text);
    validateReview(review.value.text);
    validateRating(rating.value);
  }

  bool isFormValid() {
    return nameError.value.isEmpty &&
        surnameError.value.isEmpty &&
        emailIdError.value.isEmpty &&
        phoneNumberError.value.isEmpty &&
        dobError.value.isEmpty &&
        movieNameError.value.isEmpty &&
        addressError.value.isEmpty &&
        reviewError.value.isEmpty &&
        name.value.text.isNotEmpty &&
        surname.value.text.isNotEmpty &&
        emailId.value.text.isNotEmpty &&
        phoneNumber.value.text.isNotEmpty &&
        dob.value.text.isNotEmpty &&
        address.value.text.isNotEmpty &&
        review.value.text.isNotEmpty &&
        rating.value > 0 &&
        ratingError.value.isEmpty;
  }

  void resetForm() {
    name.value.text = '';
    surname.value.text = '';
    dob.value.text = '';
    emailId.value.text = '';
    phoneNumber.value.text = '';
    address.value.text = '';
    movieName.value.text = '';
    review.value.text = '';
    rating.value = 0.0;
    selectedGender.value = 'Male';

    nameError.value = '';
    surnameError.value = '';
    emailIdError.value = '';
    phoneNumberError.value = '';
    dobError.value = '';
    movieNameError.value = '';
    addressError.value = '';
    reviewError.value = '';
    ratingError.value = '';
  }
}