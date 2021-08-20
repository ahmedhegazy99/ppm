import 'package:get/get.dart';
import 'package:pro_player_market/controllers/userController.dart';
import 'package:pro_player_market/models/playerModel.dart';
import 'package:pro_player_market/models/userModel.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';

import 'databaseController.dart';

class PostController extends GetxController {
  var _postsStream = Rxn<List<PlayerModel>>();

  List<PlayerModel>? get posts => _postsStream.value;

  @override
  void onInit() {
    _postsStream.bindStream(Get.find<DatabaseController>().getPosts());
    super.onInit();
  }

  Future<void> toggleIsLiked(PlayerModel post) async {
    try {
      final UserModel user = Get.find<UserController>().user;
      final db = Get.find<DatabaseController>();

      if (post.upvotes?.contains(user.id) == true) {
        post.upvotes!.remove(user.id);
      } else {
        if (post.upvotes == null) {
          post.upvotes = [];
        }
        post.upvotes!.add(user.id!);
      }

      await db.updatePost(post);

      //return;
    } catch (e) {
      displayError(e);
      //return;
    }
  }
}
