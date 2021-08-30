import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pro_player_market/models/playerModel.dart';
import 'package:pro_player_market/models/requestModel.dart';
import 'package:pro_player_market/models/userModel.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';

import 'databaseController.dart';

class RequestCardController extends GetxController {

  RequestModel ? request;

  var userList= RxList<UserModel>();
  var playerList = RxList<PlayerModel>();
  var requestList = RxList<RequestModel>();

  var _user = Rxn<UserModel>();
  UserModel? get user => _user.value;

  var _player = Rxn<PlayerModel>();
  PlayerModel? get player => _player.value;

  var loading = RxBool(true);

  @override
  void onInit() async {
    print("Start request card controller");
    //print(request!.playerId);
    //await getIds();
    loading.value = false;
    super.onInit();
  }

  Future<void> getIds() async {
    try {
      print(request!.playerId);
      _user.value = await Get.find<DatabaseController>().getUser(request!.userId!);
      userList.add(await Get.find<DatabaseController>().getUser(request!.userId!));
      print('getIds  ${_user.value}');
      _player.value = await Get.find<DatabaseController>().getPlayer(request!.playerId!);
      playerList.add(await Get.find<DatabaseController>().getPlayer(request!.playerId!));
      print('getIds  ${_player.value!.id}');
      requestList.add(request!);
    } catch (e) {
      displayError(e);
    }
  }

}