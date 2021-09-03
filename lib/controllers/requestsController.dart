import 'package:get/get.dart';
import 'package:pro_player_market/controllers/userController.dart';
import 'package:pro_player_market/models/playerModel.dart';
import 'package:pro_player_market/models/requestModel.dart';
import 'package:pro_player_market/models/userModel.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';
import 'authController.dart';
import 'databaseController.dart';

class RequestsController extends GetxController {
  var _requestsStream = Rxn<List<RequestModel>>();

  var userType = Get.find<UserController>().user.userType ;

  var userList= RxList<UserModel>();
  var playerList = RxList<PlayerModel>();

  List<RequestModel> ? get requests => _requestsStream.value;

  var loading = RxBool(true);

  var _pageUser = Rxn<UserModel>();
  UserModel ? get pageUser => _pageUser.value;

  @override
  void onInit() {

    if(userType == UserTypeEnum.club){
      _requestsStream.bindStream(Get.find<DatabaseController>()
          .getUserRequests(userId: Get.find<AuthController>().user?.uid));
    }else if(userType == UserTypeEnum.admin)
      _requestsStream.bindStream(Get.find<DatabaseController>().getRequests());

    _requestsStream.bindStream(Get.find<DatabaseController>().getRequests());

    getIds();
    super.onInit();
  }

  @override
  void onReady() {
    ever(_requestsStream, (dynamic newVal) {
      if (requests!.isEmpty) {
        print("empty requests");
        getIds(update: true);
      }
    });
  }


  Future<void> getIds({bool update = false}) async {
    try {
      print("get IDsssssssssssssss");
      print(requests);

      await Future.forEach(_requestsStream.value!, (RequestModel value) async {
        userList.value.add(await Get.find<DatabaseController>().getUser(value.userId!));
        playerList.value.add(await Get.find<DatabaseController>().getPlayer(value.playerId!));
      });
      /*_requestsStream.value!.map((value) async {
        print("start map");
        userList.value.add(await Get.find<DatabaseController>().getUser(value.userId!));
        playerList.value.add(await Get.find<DatabaseController>().getPlayer(value.playerId!));
        print("end map");
        print(playerList);
      });*/

      loading.value =false;
    } catch (e) {
      displayError(e);
    }
  }

  getUser(String userId) async {
    try {
      _pageUser.value = await Get.find<DatabaseController>().getUser(userId);
    } catch (e) {
      displayError(e);
    }
  }

}
