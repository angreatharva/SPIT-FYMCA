import 'package:get/get.dart';
import '../routes/app_routes.dart';

class RoleSelectionController extends GetxController {
  final String selfCallerId;
  final String userId;
  final String userName;

  RoleSelectionController({
    required this.selfCallerId,
    required this.userId,
    required this.userName,
  });

  void selectRole(bool isDoctor) {
    Get.toNamed(
      AppRoutes.joinScreen,
      arguments: {
        'selfCallerId': selfCallerId,
        'role': isDoctor,
        'userId': userId,
        'userName': userName,
      },
    );
  }
} 