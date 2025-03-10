import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController {
  final nameController = TextEditingController();
  final ucidController = TextEditingController();
  final emailController = TextEditingController();
  final suggestionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void submitFeedback() {
    if (formKey.currentState!.validate()) {
      Get.snackbar(
        "Success",
        "Feedback submitted successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    }
  }

  void clearFields() {
    nameController.clear();
    ucidController.clear();
    emailController.clear();
    suggestionController.clear();
  }
}

class FeedBackPage extends StatelessWidget {
  final FeedbackController controller = Get.put(FeedbackController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.clearFields();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text("Feedback"),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.nameController,
                  decoration: InputDecoration(labelText: "Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: controller.ucidController,
                  decoration: InputDecoration(labelText: "UCID"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your UCID";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    } else if (!GetUtils.isEmail(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: controller.suggestionController,
                  decoration: InputDecoration(labelText: "Suggestions"),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your suggestions";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.submitFeedback,
                  child: Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}