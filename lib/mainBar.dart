import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/constants.dart';
import 'controllers/authController.dart';
import 'controllers/mainBarController.dart';

class MainBar extends GetWidget<MainBarController> {
  @override
  Widget build(BuildContext context) {

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
        title: Text("Pro Player Market"),
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
      body: Obx(() => controller.tabs[controller.currentIndex]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: ppmLight,
          unselectedItemColor: Colors.white,
          selectedItemColor: ppmMain,
          items: controller.items,
          onTap: (index) {
            controller.changeIndex(index);
            //controller.userId.value = '';
          },
        ),
      ),
    );
  }
}
