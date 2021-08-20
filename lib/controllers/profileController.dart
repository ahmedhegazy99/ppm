import 'package:get/get.dart';
import 'package:pro_player_market/controllers/databaseController.dart';
import 'package:pro_player_market/models/playerModel.dart';
import 'package:pro_player_market/models/userModel.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';

class ProfileController extends GetxController {
  final String ?userId;
  ProfileController({ this.userId});

  var _user = Rxn<UserModel>();
  UserModel? get user => _user.value;

  var posts = Rx<List<PlayerModel>>([]);

  var loading = RxBool(true);

  @override
  void onInit() async {
    await getUser();
    await getUserPosts();
    loading.value = false;
    super.onInit();
  }

  Future<void> getUser() async {
    try {
      _user.value = await Get.find<DatabaseController>().getUser(userId!);

      //return;
    } catch (e) {
      displayError(e);
      //return;
    }
  }

  Future<void> getUserPosts() async {
    try {
      print(userId);
      posts.value = (await Get.find<DatabaseController>().getUserPosts(userId!))!;

      //return;
    } catch (e) {
      displayError(e);
      //return;
    }
  }
}
