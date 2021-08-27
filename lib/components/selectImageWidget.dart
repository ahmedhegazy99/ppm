import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_player_market/controllers/createPlayerController.dart';

class SelectImage extends GetWidget<CreatePlayerController> {

  var selectedImage  ;
  RxBool _done = false.obs;

  Key key = Key('key');

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        child: Container(
            key: key,
            child: _done.value?Image.file(
              selectedImage,
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ):Image.asset(
              "assets/images/placeholder.jpg",
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
        onTap: () async{
          selectedImage = await controller.selectImage();
          _done.value = true;

        },
      );
    });
  }
}
