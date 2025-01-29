// formController.dart
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
    } else if (value.length < 10) {
      reviewError.value = 'Review must be at least 10 characters';
    } else {
      reviewError.value = '';
    }
  }

  // Validate all fields at once (useful for form submission)
  void validateAllFields() {
    validateName(name.value);
    validateSurname(surname.value);
    validateEmail(emailId.value);
    validatePhoneNumber(phoneNumber.value);
    validateDob(dob.value);
    validateAddress(address.value);
    validateReview(review.value);
  }

  // Check if the entire form is valid
  bool isFormValid() {
    return nameError.value.isEmpty &&
        surnameError.value.isEmpty &&
        emailIdError.value.isEmpty &&
        phoneNumberError.value.isEmpty &&
        dobError.value.isEmpty &&
        addressError.value.isEmpty &&
        reviewError.value.isEmpty &&
        name.value.isNotEmpty &&
        surname.value.isNotEmpty &&
        emailId.value.isNotEmpty &&
        phoneNumber.value.isNotEmpty &&
        dob.value.isNotEmpty &&
        address.value.isNotEmpty &&
        review.value.isNotEmpty &&
        rating.value > 0;
  }

  // Reset all form fields
  void resetForm() {
    name.value = '';
    surname.value = '';
    dob.value = '';
    emailId.value = '';
    phoneNumber.value = '';
    address.value = '';
    review.value = '';
    rating.value = 0.0;
    selectedGender.value = 'Male';

    // Reset all error messages
    nameError.value = '';
    surnameError.value = '';
    emailIdError.value = '';
    phoneNumberError.value = '';
    dobError.value = '';
    addressError.value = '';
    reviewError.value = '';
  }
}