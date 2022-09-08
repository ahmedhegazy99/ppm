import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/controllers/userController.dart';
import 'package:pro_player_market/models/userModel.dart';
import 'package:pro_player_market/screens/announcments.dart';
import 'package:pro_player_market/screens/home.dart';
import 'package:pro_player_market/screens/profile.dart';
import 'package:pro_player_market/screens/requests.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';
import 'package:get/get.dart';


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
        icon: ImageIcon(AssetImage('assets/images/megaphone.png')),
        label: 'announcements'.tr,
        backgroundColor: Colors.black
    ),
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

  var filterIndex = 1;
  var currentLocale = Get.locale.obs;

  Future<void> addTabs()async {
  try {
    print("userType: ${userType}");

    await waitUntilDone(user!.userType);
    print("user main bar : $user");
    switch (userType) {
      case UserTypeEnum.userPlayer:
        {
          tabs.value = [
            Announcements(),
            Home(),
            Profile(),
          ];
          items.removeAt(0);
        }
        break;
      case UserTypeEnum.club:
        {
          tabs.value = [
            Announcements(),
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
            Announcements(),
            Home(),
            Profile(),
          ];
          changeIndex(2);
          filterIndex = 2;
        }
        break;
      default:
        {
          tabs.value = [Announcements(), Home(),Profile(),];
          items.removeAt(0);
        }
    }
    //Get.put(ProfileController());
  } catch(e) {
    //displayError(e);
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
    addTabs();
    init();
    print("user type mainbar : $userType");

    ever(currentLocale, (_) async {
      print(currentLocale);
      await init();
      //await addTabs();
      print("local: ${Get.locale}");
      print("currentLocal: $currentLocale");
      /*items= [
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
      ];*/
    });

    ever(_user, (_) async {
      print('new user: $_user');
      init();
    });

    super.onInit();
  }

  Future init() async {
    //userType = await Get.find<UserController>().user.userType ;
    //_user.value = await Get.find<UserController>().user ;
    //await addTabs();

    ever(Get.find<UserController>().userModel, (UserModel ? _) async {
      if (_ != null && loading.isTrue) {
        userType=_.userType;
        _user.value = _;
        await addTabs();
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

  void clear() {
    _user.value = UserModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget ppmBottomNavigationBar(){

    ever(currentLocale, (_) async {
      await init();
    });

    return Obx(() {
      return BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: ppmBack,
        unselectedItemColor: ppmLight,
        selectedItemColor: ppmMain,
        items: items,
        onTap: (index) {
          changeIndex(index);
          //controller.userId.value = '';
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
      );
    });
  }

}

