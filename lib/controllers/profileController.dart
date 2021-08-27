import 'package:get/get.dart';
import 'package:pro_player_market/controllers/databaseController.dart';
import 'package:pro_player_market/models/playerModel.dart';
import 'package:pro_player_market/models/userModel.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';

import 'mainBarController.dart';

class ProfileController extends GetxController {
  /*final */RxString ?userId = ''.obs;
  //ProfileController({ this.userId});

  var _user = Rxn<UserModel>();
  UserModel? get user => _user.value;

  var posts = Rx<List<PlayerModel>>([]);

  var loading = RxBool(true);

  @override
  void onInit() async {
    print("Start Profile controller");
    userId = Get.find<MainBarController>().userId;
    await getUser();
    await getUserPosts();
    loading.value = false;
    super.onInit();
  }

  Future<void> getUser() async {
    try {
      print(userId);
      _user.value = await Get.find<DatabaseController>().getUser(userId!.value);

      //return;
    } catch (e) {
      displayError(e);
      //return;
    }
  }

  Future<void> getUserPosts() async {
    try {
      print(userId);
      posts.value = (await Get.find<DatabaseController>().getUserPosts(userId!.value))!;

      //return;
    } catch (e) {
      displayError(e);
      //return;
    }
  }
}
