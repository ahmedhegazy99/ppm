import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/components/roundedButton.dart';
import 'package:pro_player_market/components/roundedInputField.dart';
import 'package:pro_player_market/components/selectImageWidget.dart';
import 'package:pro_player_market/controllers/createPlayerController.dart';
import 'package:pro_player_market/controllers/databaseController.dart';
import 'package:pro_player_market/utils/appRouter.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';

import 'dropDownButton.dart';

class CreatePlayer extends GetWidget<CreatePlayerController> {

  final _formKey = GlobalKey<FormState>();

  //final GlobalKey<TagsState> _globalKey = GlobalKey<TagsState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        //automaticallyImplyLeading: true,
        backgroundColor: ppmMain,
        title: Text("Football Player Market"),
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
      body: Container(
        //margin: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
        padding: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 0.0),

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  /*Stack(
                    children: [*/
                      //select logo image
                     Container(
                        width: size.width * 0.3,
                        height: size.width * 0.3,
                        color: ppmLight,
                        child: //Placeholder(),
                        SelectImage(),
                      ),
                  /*  ],
                  ),*/

                  //const SizedBox(width: 20.0),

                  SizedBox(width: size.width * 0.06),
                  Column(
                    children: [
                      RoundedInputField(
                        validator: (val) => val!.isEmpty ? 'Enter Place Name' : null,
                        keyboardType: TextInputType.name,
                        hintText: "Player Name",
                        cSize: 0.7,
                        oWidth: 0.7,
                        icon: Icons.person ,
                        controller: controller.playerNameController,
                      ),

                      SizedBox(height: size.height * 0.03),

                      DropButton(
                        cSize: 0.7,
                        oWidth: 0.7,
                        controller: controller,
                        //cities: controller.cities,
                      ),

                    ],
                  ),
                ],
              ),
              const Divider(height: 20.0, thickness: 0.5),

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
                validator: (val) => val!.isEmpty ? 'write a brief of place' : null,
                keyboardType: TextInputType.multiline,
                hintText: "Bio",
                maxLines: 4,
                controller: controller.bioController,
              ),
/*
              RoundedInputField(
                validator: (val) => val!.isEmpty ? 'provide address' : null,
                keyboardType: TextInputType.streetAddress,
                hintText: "City",
                controller: controller.cityController,
              ),
*/
              Obx(() {
                return RoundedButton(
                  text: controller.video.value.isNull
                      ? "select video".tr
                      : "done".tr,
                  color: controller.video.value.isNull
                      ? ppmMain
                      : Colors.green,
                  press: () async {
                    await controller.selectVideo();
                  }
                );
              }),

              SizedBox(height: size.height * 0.03),

              RoundedButton(
                  text: "create".tr,
                  press: () async {
                    print("create");
                    await controller.postPlayer();
                    Get.back();
                  }),

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
        ),
      ),
    );
  }
}