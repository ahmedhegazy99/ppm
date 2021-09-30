import 'package:get/get.dart';
import 'package:pro_player_market/controllers/createPlayerController.dart';
import 'package:pro_player_market/controllers/profileController.dart';
import 'package:pro_player_market/controllers/requestsController.dart';

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
    Get.put(RequestsController());
    Get.put(MainBarController());
    Get.put(ProfileController());
    Get.put(CreatePlayerController());

    /*
    ever(user, (User? _) async {
      if (_ != null) {
        print("user binding complete");
        Get.put(DatabaseController());
        Get.put(UserController());
        Get.put(PostController());
        Get.put(RequestsController());
        Get.put(MainBarController());
        //Get.put(ProfileController());
        Get.put(CreatePlayerController());
      }
    });
*/
  }
}
