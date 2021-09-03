import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/controllers/userController.dart';
import 'package:pro_player_market/models/userModel.dart';
import 'package:pro_player_market/screens/home.dart';
import 'package:pro_player_market/screens/profile.dart';
import 'package:pro_player_market/screens/requests.dart';

class MainBarController extends GetxController {

  var userType = Get.find<UserController>().user.userType ;

  var tabs;

  var items= [
    BottomNavigationBarItem(
    icon: Icon(Icons.info),
    label: 'Requests',
    backgroundColor: Colors.black),
    BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
    backgroundColor: Colors.black),
    BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: 'Profile',
    backgroundColor: Colors.black),
  ];
  
  var _index = RxInt(0);
  int get currentIndex => _index.value;

  var userId = RxString('');

  void changeIndex(int index) {
    _index.value = index;
  }

  void openPlayerProfile(String userId) {
    this.userId.value = userId;
    _index.value = 1;
  }


  Future<void> addTabs()async {
    if (userType == UserTypeEnum.admin){
      tabs = [
        Requests(),
        Home(),
        Profile(),
      ];
      changeIndex(1);
    }else{
      tabs = [
        Requests(),
        Home(),
        Profile(),
      ];
      changeIndex(1);
      //items.removeAt(0);
    }

    // tabs.map((e) {
    //
    // });
  }

  @override
  void onReady() {
    // if(Get.find<UserController>().user.userType == UserTypeEnum.admin)
    //   tabs.add(Requests());
    addTabs();
    super.onReady();
  }

}
