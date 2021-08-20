import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_player_market/controllers/userController.dart';
import 'package:pro_player_market/models/playerModel.dart';
import 'package:pro_player_market/models/userModel.dart';

import 'databaseController.dart';

class CreatepostController extends GetxController {
  final textController = TextEditingController();
  final image = Rxn<File>();

  Future<void> selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  void removeImage() async {
    image.value = null;
  }

  Future<void> postPost() async {
    UserModel user = Get.find<UserController>().user;
    if (textController.value.text.isEmpty == true)
      Get.snackbar('cantPost'.tr, 'empty'.tr,
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    else {
      PlayerModel post = PlayerModel();
      if (image.value != null)
        post.type = PostTypeEnum.photo;
      else
        post.type = PostTypeEnum.text;

      post.text = textController.value.text;
      post.userId = user.id;
      post.userImage = user.imageUrl;
      post.userName = '${user.name}';
      post.date = DateTime.now();
      post.upvotes = [];

      await Get.find<DatabaseController>().addPost(post, image: image.value);

      //image.value = null;
      textController.clear();
    }
  }
}
