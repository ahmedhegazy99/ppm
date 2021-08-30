import 'package:get/get.dart';
import 'package:pro_player_market/models/requestModel.dart';
import 'databaseController.dart';

class RequestsController extends GetxController {
  var _requestsStream = Rxn<List<RequestModel>>();

  List<RequestModel> ? get requests => _requestsStream.value;

  @override
  void onInit() {
    _requestsStream.bindStream(Get.find<DatabaseController>().getRequests());
    super.onInit();
  }

/*
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
*/
}
