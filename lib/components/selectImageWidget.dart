import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_player_market/controllers/createPlayerController.dart';

class SelectImage extends GetWidget<CreatePlayerController> {

  var selectedImage  ;
  RxBool ?done = false.obs;

  Key key = Key('key');

  SelectImage({this.selectedImage, this.done});

  @override
  Widget build(BuildContext context) {
    if(done==null)
      done = false.obs;
    return Obx(() {
      return GestureDetector(
        child: Container(
            key: key,
            child: done!.value && selectedImage!=null ?
              selectedImage is String ?
                Image.network(
                  selectedImage,
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ):
                Image.file(
                  selectedImage,
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ):
              Image.asset(
                "assets/images/placeholder.jpg",
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              ),
              /*Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png',
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),*/
          ),
        onTap: () async{
          selectedImage = await (controller.selectImage())!;
          done!.value = true;

        },
      );
    });
  }
}
