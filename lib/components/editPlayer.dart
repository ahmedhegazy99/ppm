import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/components/roundedButton.dart';
import 'package:pro_player_market/components/roundedInputField.dart';
import 'package:pro_player_market/components/selectImageWidget.dart';
import 'package:pro_player_market/components/videoPlayer.dart';
import 'package:pro_player_market/controllers/createPlayerController.dart';
import 'package:pro_player_market/controllers/databaseController.dart';
import 'package:pro_player_market/controllers/profileController.dart';
import 'package:pro_player_market/models/playerModel.dart';
import 'package:pro_player_market/utils/appRouter.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';

import 'dropDownButton.dart';

class EditPlayer extends GetWidget<CreatePlayerController> {

  final _formKey = GlobalKey<FormState>();

  PlayerModel player;
  var buttonClicked = false.obs;

  EditPlayer({
    required this.player
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    controller.playerNameController.text = player.name!;
    controller.bioController.text = player.bio!;
    controller.selectedDate.value = player.birthDate!;

    return Container(
      //margin: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
      padding: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 0.0),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      //select logo image
          Container(
          width: size.width * 0.3,
            height: size.width * 0.3,
            color: ppmLight,
            child: SelectImage(selectedImage: player.photo, done: true.obs,),
          ),

          RoundedInputField(
            validator: (val) => val!.isEmpty ? 'Enter Player Name'.tr : null,
            keyboardType: TextInputType.name,
            hintText: "Player Name".tr,
            cSize: 0.7,
            oWidth: 0.7,
            icon: Icons.person ,
            color: Colors.grey[200]!,
            controller: controller.playerNameController,
          ),

          SizedBox(height: size.height * 0.03),

          DropButton(
            cSize: 0.7,
            oWidth: 0.7,
            controller: controller,
            color: Colors.grey[200]!,
          ),

          GestureDetector(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 48, vertical: 12),
              height: size.width * 0.13,
              width: size.width * 0.8,
              decoration: BoxDecoration(
                color: ppmBack,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${controller.selectedDate.value.day}/${controller.selectedDate.value.month}/${controller.selectedDate.value.year}",
                      style: TextStyle(
                          fontSize: 16,
                          color: ppmMain
                      ),
                    ),
                    SizedBox(width: size.width * 0.02),

                    Icon(Icons.arrow_forward_ios, color: ppmMain,),
                  ]
              ),
            ),
            onTap: () async {
              print("select date clicked");
              //controller.selectDate(context);
              controller.selectedDate.value = await selectDate(context);
            },
          ),

          // RoundedButton(
          //     text: "Date",
          //     press: () async {
          //       print("select date clicked");
          //       controller.selectDate(context);
          //     }),

          RoundedInputField(
            validator: (val) => val!.isEmpty ? 'write biography of player'.tr : null,
            keyboardType: TextInputType.multiline,
            hintText: 'bio'.tr,
            maxLines: 4,
            color: Colors.grey[200]!,
            controller: controller.bioController,
          ),

          //VideoWidget(player.video),
          Container(
            color: ppmBack,
            child: Obx(() {
              return Expanded(
                child: Column(
                  children: [
                    if(controller.video.value == null)
                      VideoWidget(player.video),

                    TextButton(
                      onPressed: () async {
                        await controller.selectVideo();
                      },
                      child: Text(
                        controller.video.value.isNull
                            ? "select video".tr
                            : "done".tr,
                        style: TextStyle(
                          color: controller.video.value.isNull
                              ? ppmMain
                              : Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),

          SizedBox(height: size.height * 0.03),

          Padding(
            padding: const EdgeInsets.all(kDefaultPadding * 2),
            child: GetX<DatabaseController>(
              init: DatabaseController(),
              builder: (controller) {
                if (controller.uploading.value) return LinearProgressIndicator();
                return Container(
                  color: ppmMain,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}