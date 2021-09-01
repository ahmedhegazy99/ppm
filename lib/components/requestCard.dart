import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/controllers/userController.dart';
import 'package:pro_player_market/models/playerModel.dart';
import 'package:pro_player_market/models/requestModel.dart';
import 'package:pro_player_market/models/userModel.dart';

class RequestCard extends StatelessWidget {
  final RequestModel ? request;
  final UserModel ? user;
  final PlayerModel ? player;
  RequestCard({this.request, this.user, this.player});

  @override
  Widget build(BuildContext context) {
    var userType = Get.find<UserController>().user.userType ;
    return Card(
      child: ListTile(
          title: RichText(
            text: TextSpan(
              text: '${player!.name ?? ""} ',
              style: TextStyle(
                  color: ppmMain,
                  fontWeight: FontWeight.bold
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '${request!.title ?? ""}',
                  style: TextStyle(
                      color: ppmMain,
                      fontWeight: FontWeight.bold
                  ),
                ),
                if(userType == UserTypeEnum.admin)
                TextSpan(
                  text: ' by ${user!.name?? ""}',
                  style: TextStyle(
                      color: ppmMain,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }



}
