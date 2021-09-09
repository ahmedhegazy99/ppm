import 'package:get/get.dart';
import 'package:pro_player_market/models/userModel.dart';

import 'databaseController.dart';

class UserController extends GetxController {
  //var _userModel = UserModel().obs;
  var userModel = UserModel().obs;

  UserModel get user => userModel.value;

  set user(UserModel value) => this.userModel.value = value;

  void clear() {
    userModel.value = UserModel();
  }

  @override
  void onReady() {
    print("user usercontroller: ${user.name}");

    ever(userModel, (UserModel ? _) async {
        if (_ != null) {
          user =
          await Get.find<DatabaseController>().getUser(_.id!);
         // print("user auth usertype: ${user.userType}");
        }
    });

    super.onReady();
  }

}
