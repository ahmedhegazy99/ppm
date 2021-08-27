import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/controllers/userController.dart';
import 'package:pro_player_market/models/playerModel.dart';
import 'package:pro_player_market/models/userModel.dart';

import 'databaseController.dart';

class CreatePlayerController extends GetxController {
  final playerNameController = TextEditingController();
  final bioController = TextEditingController();
  final cityController = TextEditingController();

  final image = Rxn<File>();
  final video = Rxn<File>();

  Future selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    print('file selected');
    if (pickedFile != null) {
      print('file picked');
      image.value = File(pickedFile.path);
      print(image.value);
      return image.value;
    }
  }

 /* selectImage() async {
    final sImage = await ImagePicker().getImage(source: ImageSource.gallery);
    if(sImage != null) {
      image.value = await ImageCropper.cropImage(
          sourcePath: sImage.path,
          aspectRatio: CropAspectRatio(
              ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: ppmLight,
            toolbarTitle: "Cropper",
            //statusBarColor: Colors.deepOrange.shade900,
            backgroundColor: Colors.white,
          )
      );
      return image.value;
    }
    //return image.value;
  }
*/
  Future selectVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      video.value = File(pickedFile.path);
      return video.value;
    }
  }

  void removeImage() async {
    image.value = null;
  }

  Future<void> postPlayer() async {
    UserModel user = Get.find<UserController>().user;
    if (playerNameController.value.text.isEmpty &&
        bioController.value.text.isEmpty &&
        cityController.value.text.isEmpty &&
        image.value == null && video.value == null)
      Get.snackbar('cantPost'.tr, 'empty'.tr,
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    else {
      PlayerModel post = PlayerModel();
      /*if (image.value != null)
        post.type = PostTypeEnum.photo;
      else
        post.type = PostTypeEnum.text;
*/
      post.city = cityController.value.text;
      post.userId = user.id;
      post.bio = bioController.text;
      post.name = playerNameController.text;
      post.joinDate = DateTime.now();
      post.upvotes = [];

      //print(image.value);
      await Get.find<DatabaseController>().addPost(post, image: image.value, video: video.value);

      image.value = null;
      video.value = null;
      playerNameController.clear();
    }
  }
}
