import 'package:get/get.dart';

import '../authController.dart';
import '../databaseController.dart';
import '../mainBarController.dart';
import '../postController.dart';
import '../userController.dart';

class BindingController extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(UserController());
    Get.put(DatabaseController());
    Get.put(PostController());
    Get.put(MainBarController());
  }
}
