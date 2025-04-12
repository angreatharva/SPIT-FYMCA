import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lab_8/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  late SharedPreferences _prefs;

  @override
  void onInit() {
    super.onInit();
    // Initialize SharedPreferences
    _initPrefs();
    // Listen to auth state changes
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        // User is signed in
        _saveLoginStatus(true);
        if (Get.currentRoute != '/home') {
          Get.offAll(() => const HomePage());
        }
      } else {
        // User is signed out
        _saveLoginStatus(false);
        if (Get.currentRoute != '/login') {
          Get.offAll(() => const LoginPage());
        }
      }
    });
  }

  Future<void> _initPrefs() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      // Check if user is already logged in
      checkLoginStatus();
    } catch (e) {
      print("Error initializing SharedPreferences: $e");
    }
  }

  Future<void> checkLoginStatus() async {
    try {
      final isLoggedIn = _prefs.getBool('isLoggedIn') ?? false;
      
      if (isLoggedIn && auth.currentUser != null) {
        if (Get.currentRoute != '/home') {
          Get.offAll(() => const HomePage());
        }
      } else {
        if (Get.currentRoute != '/login') {
          Get.offAll(() => const LoginPage());
        }
      }
    } catch (e) {
      print("Error checking login status: $e");
    }
  }

  Future<void> _saveLoginStatus(bool status) async {
    try {
      await _prefs.setBool('isLoggedIn', status);
    } catch (e) {
      print("Error saving login status: $e");
    }
  }

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
      await _saveLoginStatus(true);

      Get.snackbar("Success", "Logged in with Google!");
      Get.offAll(() => const HomePage());
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

      await _saveLoginStatus(true);

      Get.snackbar("Success", "Account created successfully!");
      Get.offAll(() => const HomePage());

    } catch (e) {
      print("registerUser: $e");
      Get.snackbar("Error", e.toString());
    }
  }

  void loginUser(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      await _saveLoginStatus(true);
      
      Get.snackbar("Success", "Login successful");
      Get.offAll(() => const HomePage());
    } catch (e) {
      print("loginUser: $e");
      Get.snackbar("Error", e.toString());
    }
  }

  void logout() async {
    try {
      await auth.signOut();
      await _saveLoginStatus(false);
      Get.offAll(() => const LoginPage());
    } catch (e) {
      print("logout: $e");
      Get.snackbar("Error", e.toString());
    }
  }
}
