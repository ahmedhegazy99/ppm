import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/controllers/requestCardController.dart';
import 'package:pro_player_market/models/requestModel.dart';

class RequestCard extends GetWidget<RequestCardController> {
  final RequestModel ? request;
  RequestCard({this.request});

  @override
  Widget build(BuildContext context) {

    print(request!.playerId);
    controller.request = request;
    controller.onInit();
    print('getIdsCard  ${controller.player}');

    return Card(
      child: Obx(() {
        return ListTile(
          title: RichText(
            text: TextSpan(
              text: '${controller.player!.name ?? ""} ',
              style: TextStyle(
                  color: ppmMain,
                  fontWeight: FontWeight.bold
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '${request!.title}',
                  style: TextStyle(
                      color: ppmMain,
                      fontWeight: FontWeight.bold
                  ),
                ),
                TextSpan(
                  text: ' by ${controller.user!.name}',
                  style: TextStyle(
                      color: ppmMain,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }



}
