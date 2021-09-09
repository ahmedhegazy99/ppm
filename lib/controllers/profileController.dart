import 'dart:async';

import 'package:flutter/material.dart';
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
    print('user type: ${userType}');
    _user.value = Get.find<UserController>().user;
    super.onReady();
  }

  Future init() async {
    print("Start Profile controller");
    userId.value = (await Get.find<AuthController>().user?.uid)!; /*?? "";*/
    print('user id: ${userId.value}');
    if(userId.isNotEmpty) {
      await getUser();
      await getUserType();
      await getUserPosts();
      loading.value = false;
    }
      //loading.value = false;

  }

  // Future<void> _waitUntilDone() async {
  //
  //   final completer = Completer();
  //   if (user == null) {
  //     await 200.milliseconds.delay();
  //     return _waitUntilDone();
  //   } else {
  //     print(user);
  //     completer.complete();
  //   }
  //   return completer.future;
  // }

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
      print(user);
      waitUntilDone(user);
      switch(user!.userType){
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
          userTypeSt = "Default";
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

  Future updateMail(String mail) async {
      await Get.find<DatabaseController>().updateUser(userId.value, {'email': mail});
  }
  Future updateMobile(String mobile) async {
    await Get.find<DatabaseController>().updateUser(userId.value, {'mobile': mobile});
  }
  Future updateName(String name) async {
    await Get.find<DatabaseController>().updateUser(userId.value, {'name': name});
  }


  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController mobile = TextEditingController();

  showSheet(BuildContext context){

    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.amber,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Modal BottomSheet'),
                ElevatedButton(
                  child: const Text('Close BottomSheet'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
        );
      },
    );
  }

}
