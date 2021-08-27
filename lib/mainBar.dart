import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/screens/home.dart';
import 'package:pro_player_market/screens/profile.dart';
import 'package:pro_player_market/screens/requests.dart';

import 'controllers/authController.dart';
import 'controllers/mainBarController.dart';

class MainBar extends GetWidget<MainBarController> {
  @override
  Widget build(BuildContext context) {
    final tabs = [
      Requests(),
      Home(),
      Profile(),
      //CreatePlayer(),
    ];
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: ppmMain,
        /*title: Center(
          child: Image.asset(
            'assets/images/Hlogo.png',
            fit: BoxFit.contain,
            height: 100,
            width: 100,
          ),
        ),*/
        centerTitle: true,

        /*leading: IconButton(
          icon: SvgPicture.asset(
              "assets/icons/back.svg",
            color: ppmLight,
          ),
          onPressed: () {},
        ),*/
        actions: <Widget>[

          /*IconButton(
            icon: Icon(
              Icons.more_vert,
              color: ppmLight,
            ),
            onPressed: () {},
          ),*/
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: 0,
                child: Text(
                  "Log Out",
                ),
              ),
            ],
            onSelected: (result) async {
              switch(result) {
                case 0: {
                  Get.find<AuthController>().signOut();
                }
                break;
              }
            },
          ),
          SizedBox(width: kDefaultPadding / 2)
        ],

        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
      ),
      body: Obx(() => tabs[controller.currentIndex]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: ppmLight,
          //iconSize: 30,
          //unselectedFontSize: 20,
          unselectedItemColor: Colors.white,
          selectedItemColor: ppmMain,
          items: [
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
          ],
          onTap: (index) {
            controller.changeIndex(index);
            controller.userId.value = '';
          },
        ),
      ),
    );
  }
}
