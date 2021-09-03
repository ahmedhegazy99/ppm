import 'package:get/get.dart';
import 'package:pro_player_market/controllers/authController.dart';
import 'package:pro_player_market/controllers/databaseController.dart';
import 'package:pro_player_market/controllers/userController.dart';
import 'package:pro_player_market/models/playerModel.dart';
import 'package:pro_player_market/models/userModel.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';

import 'mainBarController.dart';

class ProfileController extends GetxController {
  /*final */var userId = RxString('');
  //ProfileController({ this.userId});

  var _user = Rxn<UserModel>();
  UserModel? get user => _user.value;

  var posts = Rx<List<PlayerModel>>([]);

  var userType = Get.find<UserController>().user.userType ;

  String ? userTypeSt;

  var loading = RxBool(true);

  @override
  void onReady() {
    init();
    print('user type: $user');
    super.onReady();
  }

  Future init() async {
    print("Start Profile controller");
    userId.value = Get.find<AuthController>().user?.uid ?? "";
    print('user id: ${userId.value}');
    if(userId.isNotEmpty) {
      await getUser();
      await getUserType();
      await getUserPosts();
      loading.value = false;
    }
      //loading.value = false;

  }

  Future<void> getUser() async {
    try {
      print(userId);
      _user.value = await Get.find<DatabaseController>().getUser(userId.value);

      //return;
    } catch (e) {
      displayError(e);
      //return;
    }
  }

  Future<void> getUserType() async {
    try {
      switch(userType){
        case UserTypeEnum.userPlayer: {
          userTypeSt = "Player";
        }
        break;
        case UserTypeEnum.club: {
          userTypeSt = "Club";
        }
        break;
        case UserTypeEnum.admin: {
          userTypeSt = "Admin";
        }
        break;
        default:{
          userTypeSt = "Player";
        }
      }

      //return;
    } catch (e) {
      displayError(e);
      //return;
    }
  }

  Future<void> getUserPosts() async {
    try {
      print(userId);
      posts.value = (await Get.find<DatabaseController>().getUserPosts(userId.value))!;

      //return;
    } catch (e) {
      displayError(e);
      //return;
    }
  }
}
