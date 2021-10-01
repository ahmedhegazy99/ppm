import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/controllers/mainBarController.dart';
import 'package:pro_player_market/screens/about/about.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: ppmMain,
          title: Text('settings'.tr),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: ppmBack,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          elevation: 0,
        ),
      body: SingleChildScrollView(
        child: /*Obx((){
          return */Container(
            child: Column(
              children: [
                GestureDetector(
                  child: ListTile(
                    leading: Icon(Icons.language, color: ppmMain,),
                    title: Text('language'.tr),
                  ),
                  onTap: (){
                    if(Get.locale == Locale('ar')){
                      Get.updateLocale(Locale('en'));
                    }else {
                      Get.updateLocale(Locale('ar'));
                    }
                    //Get.reset();
                    Get.find<MainBarController>().currentLocale.value = Get.locale;
                  },
                ),

                GestureDetector(
                  child: ListTile(
                    //leading: Icon(Icons.language, color: ppmMain,),
                    title: Text('about'.tr),
                  ),
                  onTap: (){
                    Get.to(About());
                  },
                )
              ],
            ),
          ),
        //}),
      )
    );
  }
}
