import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class FormController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    profileImagePath.value = box.read("profileImage") ?? '';
    selectedFilePath.value = box.read("resume") ?? '';
    requestPermissions();
  }
  var selectedFilePath = "".obs;
  var profileImagePath = "".obs;
  var isPdf = false.obs;
  var isImage = false.obs;
  var isProfileComplete = false.obs;

  Future<void> requestPermissions() async {
    await Permission.storage.request();
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowCompression: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null && result.files.single.path != null) {
      selectedFilePath.value = result.files.single.path!;
      String fileExtension = result.files.single.extension?.toLowerCase() ?? "";

      isPdf.value = fileExtension == 'pdf';
      isImage.value = ['jpg', 'jpeg', 'png'].contains(fileExtension);
    }
  }

  Future<void> pickProfileImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowCompression: true,
      type: FileType.image,
    );

    if (result != null && result.files.single.path != null) {
      profileImagePath.value = result.files.single.path!;
    }
  }

  final box = GetStorage();

  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> emailId = TextEditingController().obs;
  Rx<TextEditingController> phoneNumber = TextEditingController().obs;
  Rx<TextEditingController> ucid = TextEditingController().obs;

  Rx<TextEditingController> collegeNameGraduation = TextEditingController().obs;
  Rx<TextEditingController> sem1 = TextEditingController().obs;
  Rx<TextEditingController> sem2 = TextEditingController().obs;
  Rx<TextEditingController> sem3 = TextEditingController().obs;
  Rx<TextEditingController> sem4 = TextEditingController().obs;
  Rx<TextEditingController> sem5 = TextEditingController().obs;
  Rx<TextEditingController> sem6 = TextEditingController().obs;
  Rx<TextEditingController> CGPA = TextEditingController().obs;
  Rx<TextEditingController> percentageGraduation = TextEditingController().obs;

  Rx<TextEditingController> collegeNameSSC = TextEditingController().obs;
  Rx<TextEditingController> yearOfPassingSSC = TextEditingController().obs;
  Rx<TextEditingController> marksObtainedSSC = TextEditingController().obs;
  Rx<TextEditingController> totalMarksSSC = TextEditingController().obs;
  Rx<TextEditingController> percentageSSC = TextEditingController().obs;

  Rx<TextEditingController> collegeNameHSC = TextEditingController().obs;
  Rx<TextEditingController> yearOfPassingHSC = TextEditingController().obs;
  Rx<TextEditingController> marksObtainedHSC = TextEditingController().obs;
  Rx<TextEditingController> totalMarksHSC = TextEditingController().obs;
  Rx<TextEditingController> percentageHSC = TextEditingController().obs;


  var nameError = ''.obs;
  var emailIdError = ''.obs;
  var phoneNumberError = ''.obs;
  var ucidError = ''.obs;

  var collegeNameErrorGraduation= ''.obs;
  var sem1Error= ''.obs;
  var sem2Error= ''.obs;
  var sem3Error= ''.obs;
  var sem4Error= ''.obs;
  var sem5Error= ''.obs;
  var sem6Error= ''.obs;
  var CGPAError= ''.obs;
  var percentageError= ''.obs;


  var collegeNameErrorSSC = ''.obs;
  var yearOfPassingErrorSSC = ''.obs;
  var marksObtainedErrorSSC = ''.obs;
  var totalMarksErrorSSC = ''.obs;
  var percentageErrorSSC = ''.obs;

  var collegeNameErrorHSC= ''.obs;
  var yearOfPassingErrorHSC = ''.obs;
  var marksObtainedErrorHSC = ''.obs;
  var totalMarksErrorHSC = ''.obs;
  var percentageErrorHSC = ''.obs;


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

  void validateCollegeNameGraduation(String value) {
    if (value.isEmpty) {
      collegeNameErrorGraduation.value = 'College Name is required';
    } else if (value.length < 2) {
      collegeNameErrorGraduation.value = 'College Name must be at least 2 characters';
    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      collegeNameErrorGraduation.value = 'College Name can only contain letters';
    } else {
      collegeNameErrorGraduation.value = '';
    }
  }

  void validateSem1(String value) {
    if (value.isEmpty) {
      sem1Error.value = 'Sem1 are required';
    } else {
      sem1Error.value = '';
    }
  }
  void validateSem2(String value) {
    if (value.isEmpty) {
      sem2Error.value = 'Sem2 are required';
    } else {
      sem2Error.value = '';
    }
  }
  void validateSem3(String value) {
    if (value.isEmpty) {
      sem3Error.value = 'Sem3 are required';
    } else {
      sem3Error.value = '';
    }
  }
  void validateSem4(String value) {
    if (value.isEmpty) {
      sem4Error.value = 'Sem4 are required';
    } else {
      sem4Error.value = '';
    }
  }
  void validateSem5(String value) {
    if (value.isEmpty) {
      sem5Error.value = 'Sem5 are required';
    } else {
      sem5Error.value = '';
    }
  }
  void validateSem6(String value) {
    if (value.isEmpty) {
      sem6Error.value = 'Sem6 are required';
    } else {
      sem6Error.value = '';
    }
  }
  void validateCGPA() {
    double percentage = (double.parse(sem1.value.text) + double.parse(sem2.value.text) + double.parse(sem3.value.text) + double.parse(sem4.value.text) + double.parse(sem5.value.text) + double.parse(sem6.value.text)) / 6;
    CGPA.value.text = percentage.toStringAsFixed(2);
    print("CGPA: ${CGPA.value.text}");
  }
  void calculatePercentageGraduation() {
    double percentage =(7.1 *
        (double.parse(sem1.value.text) + double.parse(sem2.value.text) + double.parse(sem3.value.text) + double.parse(sem4.value.text) + double.parse(sem5.value.text) + double.parse(sem6.value.text)) / 6
    +(11))
    ;
    percentageGraduation.value.text = percentage.toStringAsFixed(2);
    print("percentageGraduation : ${percentageGraduation.value.text}");
  }

  void validateCollegeNameSSC(String value) {
    if (value.isEmpty) {
      collegeNameErrorSSC.value = 'College Name is required';
    } else if (value.length < 2) {
      collegeNameErrorSSC.value = 'College Name must be at least 2 characters';
    } else if (!RegExp(r"^[a-zA-Z\s.']+$").hasMatch(value)) {
      collegeNameErrorSSC.value = 'College Name can only contain letters';
    } else {
      collegeNameErrorSSC.value = '';
    }
  }

  void validateYearOfPassingSSC(String value) {
    if (value.isEmpty) {
      yearOfPassingErrorSSC.value = 'Year of Passing is required';
    } else {
      yearOfPassingErrorSSC.value = '';
    }
  }

  void validateMarksObtainedSSC(String value) {
    if (value.isEmpty) {
      marksObtainedErrorSSC.value = 'Marks Obtained is required';
    }else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      marksObtainedErrorSSC.value = 'Marks Obtained can only contain digits';
    } else {
      marksObtainedErrorSSC.value = '';
    }
  }

  void validateTotalMarksSSC(String value) {
    if (value.isEmpty) {
      totalMarksErrorSSC.value = 'Total Marks is required';
    }else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      totalMarksErrorSSC.value = 'Total Marks can only contain digits';
    } else {
      totalMarksErrorSSC.value = '';
    }
  }

  void calculatePercentageSSC() {
    double percentage = (double.parse(marksObtainedSSC.value.text) / double.parse(totalMarksSSC.value.text)) * 100;
    percentageSSC.value.text = percentage.toStringAsFixed(2);
    print("percentageSSC: ${percentageSSC.value.text}");
  }


  void validateCollegeNameHSC(String value) {
    if (value.isEmpty) {
      collegeNameErrorHSC.value = 'College Name is required';
    } else if (value.length < 2) {
      collegeNameErrorHSC.value = 'College Name must be at least 2 characters';
    } else if (!RegExp(r"^[a-zA-Z\s.']+$").hasMatch(value)) {
      collegeNameErrorHSC.value = 'College Name can only contain letters';
    } else {
      collegeNameErrorHSC.value = '';
    }
  }

  void validateYearOfPassingHSC(String value) {
    if (value.isEmpty) {
      yearOfPassingErrorHSC.value = 'Year of Passing is required';
    } else {
      yearOfPassingErrorHSC.value = '';
    }
  }

  void validateMarksObtainedHSC(String value) {
    if (value.isEmpty) {
      marksObtainedErrorHSC.value = 'Marks Obtained is required';
    }else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      marksObtainedErrorHSC.value = 'Marks Obtained can only contain digits';
    } else {
      marksObtainedErrorHSC.value = '';
    }
  }

  void validateTotalMarksHSC(String value) {
    if (value.isEmpty) {
      totalMarksErrorHSC.value = 'Total Marks is required';
    }else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      totalMarksErrorHSC.value = 'Total Marks can only contain digits';
    } else {
      totalMarksErrorHSC.value = '';
    }
  }

  void calculatePercentageHSC() {
    double percentage = (double.parse(marksObtainedHSC.value.text) / double.parse(totalMarksHSC.value.text)) * 100;
    percentageHSC.value.text = percentage.toStringAsFixed(2);
    print("percentageHSC: ${percentageHSC.value.text}");
  }


  void validateAllFields() {
    validateName(name.value.text);
    validateEmail(emailId.value.text);
    validatePhoneNumber(phoneNumber.value.text);
    validateUCID(ucid.value.text);
    validateCollegeNameGraduation(collegeNameGraduation.value.text);
    validateSem1(sem1.value.text);
    validateSem2(sem2.value.text);
    validateSem3(sem3.value.text);
    validateSem4(sem4.value.text);
    validateSem5(sem5.value.text);
    validateSem6(sem6.value.text);
    validateCGPA();
    calculatePercentageGraduation();
    validateCollegeNameSSC(collegeNameSSC.value.text);
    validateYearOfPassingSSC(yearOfPassingSSC.value.text);
    validateMarksObtainedSSC(marksObtainedSSC.value.text);
    validateTotalMarksSSC(totalMarksSSC.value.text);
    calculatePercentageSSC();
    validateCollegeNameHSC(collegeNameHSC.value.text);
    validateYearOfPassingHSC(yearOfPassingHSC.value.text);
    validateMarksObtainedHSC(marksObtainedHSC.value.text);
    validateTotalMarksHSC(totalMarksHSC.value.text);
    calculatePercentageHSC();
  }

  bool isFormValid() {
    return nameError.isEmpty &&
        emailIdError.isEmpty &&
        phoneNumberError.isEmpty &&
        ucidError.isEmpty &&
        collegeNameErrorGraduation.isEmpty &&
        sem1Error.isEmpty &&
        sem2Error.isEmpty &&
        sem3Error.isEmpty &&
        sem4Error.isEmpty &&
        sem5Error.isEmpty &&
        sem6Error.isEmpty &&
        CGPAError.isEmpty &&
        percentageError.isEmpty &&
        collegeNameErrorSSC.isEmpty &&
        yearOfPassingErrorSSC.isEmpty &&
        marksObtainedErrorSSC.isEmpty &&
        totalMarksErrorSSC.isEmpty &&
        percentageErrorSSC.isEmpty &&
        collegeNameErrorHSC.isEmpty &&
        yearOfPassingErrorHSC.isEmpty &&
        marksObtainedErrorHSC.isEmpty &&
        totalMarksErrorHSC.isEmpty &&
        percentageErrorHSC.isEmpty &&
        name.value.text.isNotEmpty &&
        emailId.value.text.isNotEmpty &&
        phoneNumber.value.text.isNotEmpty &&
        ucid.value.text.isNotEmpty &&
        collegeNameGraduation.value.text.isNotEmpty &&
        sem1.value.text.isNotEmpty &&
        sem2.value.text.isNotEmpty &&
        sem3.value.text.isNotEmpty &&
        sem4.value.text.isNotEmpty &&
        sem5.value.text.isNotEmpty &&
        sem6.value.text.isNotEmpty &&
        CGPA.value.text.isNotEmpty &&
        percentageGraduation.value.text.isNotEmpty &&
        collegeNameSSC.value.text.isNotEmpty &&
        yearOfPassingSSC.value.text.isNotEmpty &&
        marksObtainedSSC.value.text.isNotEmpty &&
        totalMarksSSC.value.text.isNotEmpty &&
        percentageSSC.value.text.isNotEmpty &&
        collegeNameHSC.value.text.isNotEmpty &&
        yearOfPassingHSC.value.text.isNotEmpty &&
        marksObtainedHSC.value.text.isNotEmpty &&
        totalMarksHSC.value.text.isNotEmpty &&
        percentageHSC.value.text.isNotEmpty;
  }

  void storeFormValues() {

      box.write('name', name.value.text);
      box.write('emailId', emailId.value.text);
      box.write('phoneNumber', phoneNumber.value.text);
      box.write('ucid', ucid.value.text);
      box.write('collegeNameGraduation', collegeNameGraduation.value.text);
      box.write('sem1', sem1.value.text);
      box.write('sem2', sem2.value.text);
      box.write('sem3', sem3.value.text);
      box.write('sem4', sem4.value.text);
      box.write('sem5', sem5.value.text);
      box.write('sem6', sem6.value.text);
      box.write('CGPA', CGPA.value.text);
      box.write('percentageGraduation', percentageGraduation.value.text);
      box.write('collegeNameSSC', collegeNameSSC.value.text);
      box.write('yearOfPassingSSC', yearOfPassingSSC.value.text);
      box.write('marksObtainedSSC', marksObtainedSSC.value.text);
      box.write('totalMarksSSC', totalMarksSSC.value.text);
      box.write('percentageSSC', percentageSSC.value.text);
      box.write('collegeNameHSC', collegeNameHSC.value.text);
      box.write('yearOfPassingHSC', yearOfPassingHSC.value.text);
      box.write('marksObtainedHSC', marksObtainedHSC.value.text);
      box.write('totalMarksHSC', totalMarksHSC.value.text);
      box.write('percentageHSC', percentageHSC.value.text);
      box.write('profileImage', profileImagePath.value);
      box.write('resume', selectedFilePath.value);
      box.write('isPdf', isPdf.value);
      box.write('isProfileComplete', isProfileComplete.value);


      print('Form data stored successfully!');
  }

  void resetForm() {
    name.value.clear();
    emailId.value.clear();
    phoneNumber.value.clear();
    ucid.value.clear();
    collegeNameGraduation.value.clear();
    sem1.value.clear();
    sem2.value.clear();
    sem3.value.clear();
    sem4.value.clear();
    sem5.value.clear();
    sem6.value.clear();
    CGPA.value.clear();
    percentageGraduation.value.clear();
    collegeNameSSC.value.clear();
    yearOfPassingSSC.value.clear();
    marksObtainedSSC.value.clear();
    totalMarksSSC.value.clear();
    percentageSSC.value.clear();
    collegeNameHSC.value.clear();
    yearOfPassingHSC.value.clear();
    marksObtainedHSC.value.clear();
    totalMarksHSC.value.clear();
    percentageHSC.value.clear();

    nameError.value = '';
    emailIdError.value = '';
    phoneNumberError.value = '';
    ucidError.value = '';
    collegeNameErrorGraduation.value = '';
    sem1Error.value = '';
    sem2Error.value = '';
    sem3Error.value = '';
    sem4Error.value = '';
    sem5Error.value = '';
    sem6Error.value = '';
    CGPAError.value = '';
    percentageError.value = '';
    collegeNameErrorSSC.value = '';
    yearOfPassingErrorSSC.value = '';
    marksObtainedErrorSSC.value = '';
    totalMarksErrorSSC.value = '';
    percentageErrorSSC.value = '';
    collegeNameErrorHSC.value = '';
    yearOfPassingErrorHSC.value = '';
    marksObtainedErrorHSC.value = '';
    totalMarksErrorHSC.value = '';
    percentageErrorHSC.value = '';
  }

}