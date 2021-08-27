import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/components/playerCard.dart';
import 'package:pro_player_market/controllers/postController.dart';

class Home extends GetWidget<PostController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.only(top: kDefaultPadding/2),
        child: Obx(() {
          if (controller.posts!.isEmpty == true || controller.posts == null)
            return Column(
              children: [
                Center(
                  child: Text('noPosts'.tr),
                ),
              ],
            );

          return ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: controller.posts!.length,
            itemBuilder: (context, index) {
              return PlayerCard(
                player: controller.posts![index],
              );
            },
          );
        }),
      ),
    );
  }
}
