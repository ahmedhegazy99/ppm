import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/screens/settings.dart';
import 'controllers/authController.dart';
import 'controllers/mainBarController.dart';
import 'controllers/postController.dart';
import 'models/userModel.dart';

class MainBar extends GetWidget<MainBarController> {

  var _showFliterBar = RxBool(false);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: ppmMain,
        title: Flex(
          direction: Axis.horizontal,
          children: [
            Image.asset(
              'assets/images/fpm.png',
              fit: BoxFit.contain,
              height: 30,
              width: 30,
            ),
            SizedBox(width: kDefaultPadding / 3),
            Text("FPM"),
          ]
        ),
        //title: Text("Football Player Market"),
        //centerTitle: true,
        actions: <Widget>[
/*
          if (controller.userType != UserTypeEnum.admin)
            if(controller.currentIndex == 0)
              IconButton(
                icon: Icon(
                  Icons.filter_alt,
                  color: ppmBack,
                ),
                onPressed: () {},
              ),

          if (controller.userType == UserTypeEnum.admin)
            if(controller.currentIndex == 1)
              IconButton(
                icon: Icon(
                  Icons.filter_alt,
                  color: ppmBack,
                ),
                onPressed: () {},
              ),
*/
          IconButton(
            icon: Icon(
              Icons.filter_alt,
              color: ppmBack,
            ),
            onPressed: () {
              Get.find<PostController>().showFliterBar.toggle();
              print("Filter Button clicked value is : ${Get.find<PostController>().showFliterBar}");
              //Get.find<PostController>().update();
            },
          ),

          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
               PopupMenuItem(
                value: 1,
                child: Text(
                  "settings".tr,
                ),
              ),
              PopupMenuItem(
                value: 0,
                child: Text(
                  "logout".tr,
                ),
              ),
            ],
            onSelected: (result) async {
              switch(result) {
                case 0: {
                  Get.find<AuthController>().signOut();
                }
                break;

                case 1: {
                  Get.to(Settings());
                }
                break;
              }
            },
          ),
          SizedBox(width: kDefaultPadding / 2)
        ],
        //bottom: controller.putDropdown(),
        elevation: 0,
        /*shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),*/
      ),
      body: Obx(() => controller.tabs[controller.currentIndex]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: ppmBack,
          unselectedItemColor: ppmLight,
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
