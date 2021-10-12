import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/components/playerCard.dart';
import 'package:pro_player_market/controllers/postController.dart';

class Home extends GetWidget<PostController> {
  @override
  Widget build(BuildContext context) {
    return Obx((){
        return Scaffold(
          appBar: controller.showFliterBar.value ? AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: ppmBack,
            title: controller.putDropdown(),
            centerTitle: true,
            elevation: 0,
          ) : PreferredSize(preferredSize: Size(0.0, 0.0),child: Container(),),
          body: Container(
            color: Colors.grey[200],
            //padding: EdgeInsets.only(top: kDefaultPadding/2),
            child: Obx(() {
              if(controller.loading.value){
                return Center(child: CircularProgressIndicator(color: ppmMain,));
              }
              if (controller.posts == null || controller.posts!.isEmpty == true)
                return Column(
                  children: [
                    Center(
                      child: Text('noPosts'.tr),
                    ),
                  ],
                );

              return Obx(() {
                return RefreshIndicator(
                  onRefresh: () {
                    return Future.delayed(
                      Duration(seconds: 1),
                      () {
                        controller.update();
                      },
                    );
                  },
                  child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: controller.posts!.length,
                  itemBuilder: (context, index) {
                    return PlayerCard(
                      player: controller.posts![index],
                      owner: controller.owners![index],
                    );
                  },
              ),
                );
              });
            }),
          ),
        );
      }
    );
  }
}
