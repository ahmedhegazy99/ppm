import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/models/playerModel.dart';
import 'package:pro_player_market/models/requestModel.dart';
import 'package:pro_player_market/models/userModel.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';
import 'databaseController.dart';

class RequestsController extends GetxController {
  var _requestsStream = Rxn<List<RequestModel>>();

  var userList= RxList<UserModel>();
  var playerList = RxList<PlayerModel>();

  List<RequestModel> ? get requests => _requestsStream.value;

  @override
  void onInit() {
    _requestsStream.bindStream(Get.find<DatabaseController>().getRequests());
    getIds();
    super.onInit();
  }

  @override
  void onReady() {
    getIds();
    super.onReady();
  }

  Future<void> getIds() async {
    try {
      print("get IDsssssssssssssss");
      print(requests);
      requests!.map((value) async {
        print("start map");
        userList.add(await Get.find<DatabaseController>().getUser(value.userId!));
        playerList.add(await Get.find<DatabaseController>().getPlayer(value.playerId!));
        print("end map");
        print(playerList);
      });

    } catch (e) {
      displayError(e);
    }
  }

}
