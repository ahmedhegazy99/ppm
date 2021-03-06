import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/controllers/userController.dart';
import 'package:pro_player_market/models/playerModel.dart';
import 'package:pro_player_market/models/requestModel.dart';
import 'package:pro_player_market/models/userModel.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';
import 'authController.dart';
import 'databaseController.dart';
import 'mainBarController.dart';

class RequestsController extends GetxController {
  var _requestsStream = Rxn<List<RequestModel>>();

  var userType = Get.find<UserController>().user.userType ;

  var userList= RxList<UserModel>();
  var playerList = RxList<PlayerModel>();
  var ownerUserList= RxList<UserModel>();

  List<RequestModel> ? get requests => _requestsStream.value;

  var loading = RxBool(true);

  var _pageUser = Rxn<UserModel>();
  UserModel ? get pageUser => _pageUser.value;
  //set pageUser(UserModel ? value) => this._pageUser.value = value;
  set pageUser(value) => this._pageUser.value = value;

  @override
  void onInit() {

    ever(Get.find<UserController>().userModel, (UserModel newVal) {
      _pageUser.value = newVal ;
      //_pageUser.value = Get.find<UserController>().user;
      //print("new val usertype : ${newVal.userType}");
      if(newVal != null && loading.isTrue) {
        if (pageUser!.userType == UserTypeEnum.club) {
          _requestsStream.bindStream(Get.find<DatabaseController>()
              .getUserRequests(userId: Get
              .find<AuthController>()
              .user
              ?.uid));
          getIds();
          loading.value = false;
        } else if (pageUser!.userType == UserTypeEnum.admin) {
          _requestsStream.bindStream(
              Get.find<DatabaseController>().getRequests());
          print("new val usertype : ${newVal.userType}");
          getIds();
          loading.value = false;
        }
      }
    });

    super.onInit();
  }

  @override
  void onReady() {

    ever(_requestsStream, (dynamic newVal) {
      getIds(update: true);
      if (requests!.isEmpty) {
        print("empty requests");
        getIds(update: true);
        //loading.value = false;
      }
    });
  }


  Future<void> getIds({bool update = false}) async {
    try {
      print("get IDsssssssssssssss");
      print(requests);

      await Future.forEach(_requestsStream.value!, (RequestModel value) async {
        userList.add(await Get.find<DatabaseController>().getUser(value.userId!));
        /*if(value.type == RequestTypeEnum.deal) {
          playerList.add(
              await Get.find<DatabaseController>().getPlayer(value.info!));
        }else if(value.type == RequestTypeEnum.post){
          playerList.add(value.info);
        }*/
        playerList.add(
            await Get.find<DatabaseController>().getPlayer(value.info!));
        ownerUserList.add(
            await getUser(playerList.last.userId!));
        print("requests length : ${requests!.length}");
        print("users length : ${userList.length}");
        print("players length : ${playerList.length}");
      });

      /*_requestsStream.value!.map((value) async {
        print("start map");
        userList.value.add(await Get.find<DatabaseController>().getUser(value.userId!));
        playerList.value.add(await Get.find<DatabaseController>().getPlayer(value.playerId!));
        print("end map");
        print(playerList);
      });*/

      /*if() {
        print(requests);
        loading.value = false;
        print(loading.value);
      }*/
      //print(loading.value);
    } catch (e) {
      //displayError(e);
    }
  }

  Future<UserModel> getUser(String userId) async {
    try {
      UserModel u = await Get.find<DatabaseController>().getUser(userId);
      return u;
    } catch (e) {
      throw Exception("User Not Found");
      //displayError(e);
    }
  }

  Future<void> confirmAction(VoidCallback function) async {
    TextEditingController t = TextEditingController();
    try {
      bool? confirm = await Get.defaultDialog<bool>(
          title: "${"Write".tr} confirm ${'or'.tr +' '+ 'press'.tr +' '+ 'cancel'.tr}",
          content: TextField(
            controller: t,
            decoration: InputDecoration(
                hintText: "${'Write'.tr} confirm",
                border: UnderlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.blue),
                )
            ),
          ),

          actions: [
            ElevatedButton(
              onPressed: () async {
                if (t.text == 'confirm') {
                  function();
                  Get.back(result: true);
                }
              },
              child: Text('confirm'.tr),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(ppmBack),
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
            ),
            ElevatedButton(
              onPressed: () => Get.back(result: false),
              child: Text('cancel'.tr),
            )
          ]);
      if (confirm!) {
      }
    } catch (e) {
      displayError(e.toString());
    }
  }
/*  confirmAction(BuildContext context, /*void function*/){
    TextEditingController t = TextEditingController();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("${"Write".tr} confirm ${'or'.tr +' '+ 'press'.tr +' '+ 'cancel'.tr}"),
            content: TextField(
              controller: t,
              decoration: InputDecoration(
                hintText: "${'Write'.tr} confirm",
                border: UnderlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.blue),
                )
              ),
            ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    if (t.text == 'confirm') {
                      Get.back(result: true);
                    }
                  },
                  child: Text('delete'.tr),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(ppmBack),
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Get.back(result: false),
                  child: Text('cancel'.tr),
                )
              ]
          );
          /*Container(
            child: Column(
              children: [
                //Text("delete".tr),
                Text("${"Write".tr} confirm ${'or'.tr +' '+ 'press'.tr +' '+ 'cancel'.tr}"),
                TextField(controller: t,),

                Flex(
                  direction: Axis.horizontal,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          if (t.text == 'confirm'){
                            //function;
                          }
                        },
                        child: Text('confirm'.tr)
                    ),
                    ElevatedButton(
                        onPressed: (){
                          Get.back();
                        },
                        child: Text('cancel'.tr)
                    ),
                  ],
                ),
              ],
            ),
          );*/
        });
  }*/

}
