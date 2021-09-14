import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/controllers/databaseController.dart';
import 'package:pro_player_market/controllers/postController.dart';
import 'package:pro_player_market/controllers/userController.dart';
import 'package:pro_player_market/models/cityModel.dart';
import 'package:pro_player_market/models/userModel.dart';
import 'package:pro_player_market/screens/home.dart';
import 'package:pro_player_market/screens/profile.dart';
import 'package:pro_player_market/screens/requests.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';

class MainBarController extends GetxController {

  var userType;// = Get.find<UserController>().user.userType ;
  var _user = Rxn<UserModel>();
  UserModel? get user => _user.value;
  var tabs = RxList();

  var items= [
    BottomNavigationBarItem(
    icon: Icon(Icons.info),
    label: 'requests'.tr,
    backgroundColor: Colors.black),
    BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'home'.tr,
    backgroundColor: Colors.black),
    BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: 'profile'.tr,
    backgroundColor: Colors.black),
  ];
  
  var _index = RxInt(0);
  int get currentIndex => _index.value;

  var userId = RxString('');

  var loading = true.obs;

  void changeIndex(int index) {
    _index.value = index;
  }

  void openPlayerProfile(String userId) {
    this.userId.value = userId;
    _index.value = 1;
  }

  get userTabs => addTabs();

  Future<void> addTabs()async {
  try {
    print("userType: ${userType}");

    await waitUntilDone(user!.userType);
    print("user main bar : $user");
    switch (userType) {
      case UserTypeEnum.userPlayer:
        {
          tabs.value = [
            Home(),
            Profile(),
          ];
          items.removeAt(0);
        }
        break;
      case UserTypeEnum.club:
        {
          tabs.value = [
            Home(),
            Profile(),
          ];
          items.removeAt(0);
        }
        break;
      case UserTypeEnum.admin:
        {
          tabs.value = [
            Requests(),
            Home(),
            Profile(),
          ];
          changeIndex(1);
        }
        break;
      default:
        {
          tabs.value = [Home(),Profile(),];
          items.removeAt(0);
        }
    }
  } catch(e) {
    displayError(e);
  }
    /*
    if (userType == UserTypeEnum.admin){
      tabs.value = [
        Requests(),
        Home(),
        Profile(),
      ];
      changeIndex(1);
    }else{
      tabs.value = [
        //Requests(),
        Home(),
        Profile(),
      ];
      //changeIndex(1);
      items.removeAt(0);
    }
*/
    // tabs.map((e) {
    //
    // });
  }
/*
  @override
  void onReady() {
    _user.value = Get.find<UserController>().user ;
    ever(_user, (UserModel ? _) async {
      //while(user.userType == null) {
      if (_ != null) {
        addTabs();
        print("user type: ${user!.userType}");
      }
      //}
    });
    //addTabs();
    super.onReady();
  }
*/
  @override
  void onInit() {
    //userType = Get.find<UserController>().user.userType ;
    //_user.value = Get.find<UserController>().user ;
    init();
    print("user type mainbar : $userType");
    super.onInit();
  }

  Future init() async {
    //userType = await Get.find<UserController>().user.userType ;
    //_user.value = await Get.find<UserController>().user ;
    ever(Get.find<UserController>().userModel, (UserModel ? _) async {
      if (_ != null && loading.isTrue) {
        userType=_.userType;
        _user.value = _;
        addTabs();
        print("user type: ${user!.userType}");
        loading.value = false;
      }
    });
    /*
    if(_user.value!.userType != null) {
      await addTabs();
      //loading.value = false;
    }*/
    print("user type mainbar init : $userType");
  }
}

