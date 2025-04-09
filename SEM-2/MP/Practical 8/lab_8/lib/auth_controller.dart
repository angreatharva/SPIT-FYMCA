import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lab_8/home_screen.dart';

import 'login_page.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Future<void> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        Get.snackbar("Cancelled", "Google sign-in cancelled");
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google [UserCredential]
      await auth.signInWithCredential(credential);

      Get.snackbar("Success", "Logged in with Google!");
    } catch (e) {
      print("signInWithGoogle: $e");
      Get.snackbar("Error", e.toString());
    }
  }

  void registerUser(String name, String email, String password) async {
    try {
      UserCredential userCred = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await firestore.collection("users").doc(userCred.user!.uid).set({
        "name": name,
        "email": email,
        "createdAt": DateTime.now(),
      });

      Get.snackbar("Success", "Account created successfully!");
      await Future.delayed(Duration(seconds: 2));
      Get.off(() => HomeScreen());

    } catch (e) {
      print("registerUser: $e");
      Get.snackbar("Error", e.toString());
    }
  }

  void loginUser(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Success", "Login successful");
      await Future.delayed(Duration(seconds: 2));
      Get.off(() => HomeScreen());
    } catch (e) {
      print("loginUser: $e");
      Get.snackbar("Error", e.toString());
    }
  }

  void logout() async {
    await auth.signOut();
    Get.offAll(const LoginPage());
  }
}
