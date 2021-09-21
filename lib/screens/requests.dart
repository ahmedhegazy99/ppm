import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/components/requestCard.dart';
import 'package:pro_player_market/controllers/databaseController.dart';
import 'package:pro_player_market/controllers/requestsController.dart';

class Requests extends GetWidget<RequestsController> {
  @override
  Widget build(BuildContext context) {

    controller.onInit();

    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: Obx(() {
          if(controller.loading.value){
            return Center(child: CircularProgressIndicator(color: ppmMain,));
          }
          if (controller.requests == null || controller.requests!.isEmpty == true || controller.userList.isEmpty || controller.playerList.isEmpty)
            return Column(
              children: [
                Center(
                  child: Text('no pending Requests'.tr),
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
                itemCount: controller.requests!.length,
                itemBuilder: (context, index) {
                  return RequestCard(
                    request: controller.requests![index],
                    user: controller.userList[index],
                    player: controller.playerList[index],
                  );
                },
              ),
            );
          });
        }),
      ),
    );
  }
}
