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
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: Obx(() {
          if (controller.requests!.isEmpty == true || controller.requests == null)
            return Column(
              children: [
                Center(
                  child: Text('no pending Requests'.tr),
                ),
              ],
            );

          return ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: controller.requests!.length,
            itemBuilder: (context, index) {
              return RequestCard(
                request: controller.requests![index],
              );
            },
          );
        }),
      ),
    );
  }
}
