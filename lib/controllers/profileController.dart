import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/components/roundedButton.dart';
import 'package:pro_player_market/components/roundedInputField.dart';
import 'package:pro_player_market/controllers/authController.dart';
import 'package:pro_player_market/controllers/databaseController.dart';
import 'package:pro_player_market/controllers/userController.dart';
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

  var loading = RxBool(true);

  @override
  void onReady() {
    init();
    print('user type: ${userType}');
    _user.value = Get.find<UserController>().user;
    fireUser = Get.find<AuthController>().user;
    super.onReady();
  }

  Future init() async {
    print("Start Profile controller");
    userId.value = (await Get.find<AuthController>().user?.uid)!; /*?? "";*/
    print('user id: ${userId.value}');
    if(userId.isNotEmpty) {
      await getUser();
      await getUserType();
      await getUserPosts();
      loading.value = false;
    }
      //loading.value = false;

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
      posts.value = (await Get.find<DatabaseController>().getUserPosts(userId.value))!;

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

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  showSheet(BuildContext context, String key){

    return showModalBottomSheet<void>(
      context: context,
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
              showForm(),


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
                        user!.email = email.text;
                        user!.mobile = mobile.text;
                        await updateUserContacts(user!);
                        await updateMobile(mobile.text);
                      }
                    }
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }





  showForm(){
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
            validator: (val) =>
            val!.isEmpty ? "Password didn't match" : null,
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
}

