import 'package:get/get.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/controllers/userController.dart';
import 'package:pro_player_market/models/playerModel.dart';
import 'package:pro_player_market/models/requestModel.dart';
import 'package:pro_player_market/models/userModel.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';
import 'package:flutter/material.dart';
import 'databaseController.dart';

class PostController extends GetxController {
  var _postsStream = Rxn<List<PlayerModel>>();

  List<PlayerModel> ? get posts => _postsStream.value;

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

  Future<void> BuyRequest(String playerid) async {
    UserModel user = Get.find<UserController>().user;

    RequestModel req = RequestModel();

    req.type = RequestTypeEnum.buy;

    req.userId = user.id;
    req.playerId = playerid;
    req.requestDate = DateTime.now();
    req.title = 'Player Buy Request';

    await Get.find<DatabaseController>().CreateBuyRequest(req);

    await Future.delayed(Duration(seconds: 30), () {
      Get.defaultDialog(
        title: 'Done'.tr, content: Icon(Icons.verified_rounded), backgroundColor: ppmMain
      );
    });

    Get.back();

  }

}
