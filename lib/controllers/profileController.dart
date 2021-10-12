import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/components/roundedButton.dart';
import 'package:pro_player_market/components/roundedInputField.dart';
import 'package:pro_player_market/controllers/authController.dart';
import 'package:pro_player_market/controllers/databaseController.dart';
import 'package:pro_player_market/controllers/postController.dart';
import 'package:pro_player_market/controllers/userController.dart';
import 'package:pro_player_market/models/cityModel.dart';
import 'package:pro_player_market/models/playerModel.dart';
import 'package:pro_player_market/models/userModel.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';

import 'mainBarController.dart';

class ProfileController extends GetxController {
  /*final */var userId = RxString('');
  //ProfileController({ this.userId});

  var _user = Rxn<UserModel>();
  UserModel? get user => _user.value;

  var posts = Rx<List<PlayerModel>>([]);

  var userType = Get.find<UserController>().user.userType ;

  String ? userTypeSt;

  User? fireUser;

  var cities = RxList<CityModel>();

  var loading = RxBool(true);

  @override
  void onReady() {
    init();
    ever(Get.find<UserController>().userModel, (UserModel ? _) async {
      if (_ != null && loading.value) {
        init();
        print('user type: ${userType}');
        _user.value = Get.find<UserController>().user;
        fireUser = Get.find<AuthController>().user;
        cities.bindStream(Get.find<DatabaseController>().getCities());
      }
    });
    // init();
    // print('user type: ${userType}');
    // _user.value = Get.find<UserController>().user;
    // fireUser = Get.find<AuthController>().user;
    // cities.bindStream(Get.find<DatabaseController>().getCities());
    super.onReady();
  }

  Future init() async {
    print("Start Profile controller");
    if(await Get.find<AuthController>().user?.uid != null) {
      userId.value = (await Get
          .find<AuthController>()
          .user
          ?.uid)!;
    }/*?? "";*/
    print('user id: ${userId.value}');
    if(userId.isNotEmpty) {
      await getUser();
      await getUserType();
      await getUserPosts();
      loading.value = false;
    }
      //loading.value = false;
    //cities.value = (Get.find<PostController>().cities.value)!;
  }

  // Future<void> _waitUntilDone() async {
  //
  //   final completer = Completer();
  //   if (user == null) {
  //     await 200.milliseconds.delay();
  //     return _waitUntilDone();
  //   } else {
  //     print(user);
  //     completer.complete();
  //   }
  //   return completer.future;
  // }

  Future<void> getUser() async {
    try {
      print(userId);
      _user.value = await Get.find<DatabaseController>().getUser(userId.value);

      //return;
    } catch (e) {
      displayError(e);
      //return;
    }
  }

  Future<void> getUserType() async {
    try {
      print(user);
      waitUntilDone(user);
      switch(user!.userType){
        case UserTypeEnum.userPlayer: {
          userTypeSt = "Player";
        }
        break;
        case UserTypeEnum.club: {
          userTypeSt = "Club";
        }
        break;
        case UserTypeEnum.admin: {
          userTypeSt = "Admin";
        }
        break;
        default:{
          userTypeSt = "Default";
        }
      }

      //return;
    } catch (e) {
      displayError(e);
      //return;
    }
  }

  Future<void> getUserPosts() async {
    try {
      print(userId);
      //posts.value = (await Get.find<DatabaseController>().getUserPosts(userId.value))!;
      posts.bindStream(Get.find<DatabaseController>().getUserPosts(userId.value));
      //return;
    } catch (e) {
      displayError(e);
      //return;
    }
  }

  Future updateMail(String mail) async {
      await Get.find<DatabaseController>().updateUser(userId.value, {'email': mail});
  }
  Future updateMobile(String mobile) async {
    await Get.find<AuthController>().updateUserPhone(mobile);
  }
  Future updateUserContacts(UserModel user) async {
    await Get.find<DatabaseController>().updateUser(userId.value, user.toJson());
  }
  Future updatePassword(String password) async {
    await Get.find<AuthController>().updateUserPass(password);
  }

  Future updateUserPhoto() async {
    var photo;
    final sImage = await ImagePicker().getImage(source: ImageSource.gallery);
    if(sImage != null) {
      photo = await ImageCropper.cropImage(
        sourcePath: sImage.path,
        aspectRatio: CropAspectRatio(
            ratioX: 5, ratioY: 4),
        compressQuality: 100,
        //maxWidth: 700,
        //maxHeight: 700,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: ppmLight,
          toolbarTitle: "Crop",
          //statusBarColor: Colors.deepOrange.shade900,
          backgroundColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
        ),
        iosUiSettings: IOSUiSettings(
          title: 'Crop',
        ),
      );
    }
    user!.imageUrl =
    await Get.find<DatabaseController>().uploadUserImage(user!, photo);
    await Get.find<DatabaseController>().updateUser(userId.value, user!.toJson());
    await Get.find<AuthController>().updateUserPhoto(user!.imageUrl!);
  }


  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController city = TextEditingController();


  showSheet(BuildContext context, String key){

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          //height: 200,
          color: ppmMain,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                if(key == "email")
                  RoundedInputField(
                    validator: (val) => val!.isEmpty ? 'Enter an Email' : null,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "email".tr,
                    icon: Icons.mail,
                    controller: email,
                    textColor: ppmMain,
                  ),

                if(key == "mobile")
                  RoundedInputField(
                    validator: (val) =>
                    val!.isEmpty ? 'Enter mobile number' : null,
                    keyboardType: TextInputType.phone,
                    hintText: "phone".tr,
                    icon: Icons.phone,
                    controller: mobile,
                    textColor: ppmMain,
                  ),
                if(key == "password")
                  showForm(context),

                if(key == "cities")
                  showCities(),

                if(key != "cities")
                  ElevatedButton(
                    child: Text('update'.tr),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(ppmMain),
                      backgroundColor: MaterialStateProperty.all(ppmBack),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (key == "password" &&
                            password.text == confirmPassword.text){
                          updatePassword(password.text);
                        }else{
                          if(email.text.isNotEmpty)
                            user!.email = email.text;
                          if(email.text.isNotEmpty)
                            user!.mobile = mobile.text;
                          await updateUserContacts(user!);
                        }
                      }
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  showForm(BuildContext context){
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          RoundedInputField(
            validator: (val) => val!.isEmpty ? 'Enter an password' : null,
            color: Colors.white,
            textColor: Colors.black,
            obscureText: true,
            icon: Icons.lock,
            hintText: "password".tr,
            controller: password,
          ),

          RoundedInputField(
            validator: (val) => val!.isEmpty ? "Password didn't match" : null,
            color: Colors.white,
            textColor: Colors.black,
            obscureText: true,
            icon: Icons.lock,
            hintText: "confirm password".tr,
            controller: confirmPassword,
          ),
        ],
      ),
    );
  }

  showCities(){
    return Container(
      //height: Get.height * 0.5,
      child: Column(
        children: [
         /* Obx((){
            return*/ Container(
            height: Get.height * 0.5,
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: cities.length-1,
                itemBuilder: (context, index) {
                  return Container(
                    color: ppmBack,
                    margin: EdgeInsets.symmetric(vertical: 1),
                    child: ListTile(
                      title: Text('${cities[index+1].cityName}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await Get.find<DatabaseController>().deleteCity(cities[index+1].id!);
                          Get.back();
                        },
                      ),
                    ),
                  );
                },
              /*);
          }*/),
            ),

          RoundedInputField(
            validator: (val) =>
            val!.isEmpty ? 'Enter city name' : null,
            keyboardType: TextInputType.name,
            hintText: "city".tr,
            icon: Icons.location_on,
            controller: city,
            textColor: ppmMain,
          ),
          SizedBox(height: Get.height * 0.01,),
          RoundedButton(
              text: "add".tr,
              //coff: 1.5,
              color: ppmBack,
              textColor: ppmMain,
              press: () async {
                CityModel newCity = CityModel(
                  id: '${cities.length + 1}',
                  cityName: city.text,
                );
                Get.find<DatabaseController>().addCity(newCity);
                city.clear();
                Get.back();
              }
          ),
        ],
      ),
    );
  }

}

