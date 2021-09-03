import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/controllers/userController.dart';
import 'package:pro_player_market/models/userModel.dart';
import 'package:pro_player_market/utils/appRouter.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'databaseController.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  var _user = Rxn<User>();
  var loading = false.obs;
  var userType = UserTypeEnum.userPlayer.obs;
  User? get user => _user.value;

  @override
  void onReady() {
    _user.bindStream(_auth.authStateChanges());
    ever(_user, (User? _) async {
      if (_ != null) {
        Get.find<UserController>().user =
            await Get.find<DatabaseController>().getUser(_.uid);
      }
    });
    ever(loading, (bool? val) {
      //!= null is add by me not sure of it
      if (val != null && val)
        Get.defaultDialog(
            title: 'loading'.tr, content: CircularProgressIndicator());
      else
        Get.back();
    });
  }

  void createUser(String name, /*UserTypeEnum userType,*/ String email,
      String mobile, String password) async {
    try {
      loading.toggle();
      UserCredential _authResult = /* AuthResult _authResult =*/ await _auth
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password);
      UserModel _user = UserModel(
          id: _authResult.user!.uid,
          name: name,
          userType: userType.value,
          mobile: mobile,
          email: email);
      await Get.find<DatabaseController>().createNewUser(_user);
      Get.offAllNamed(AppRouter.mainBarRoute);
      loading.toggle();
      Get.back();
    } catch (e) {
      loading.toggle();
      displayError(e);
    }
  }

  void login(String email, String password) async {
    try {
      loading.toggle();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed(AppRouter.mainBarRoute);
      // Get.offAllNamed(AppRouter.contactRoute);
      print("start");
      loading.toggle();
      print("finish");
    } catch (e) {
      loading.toggle();
      displayError(e);
    }
  }

  void signOut() async {
    try {
      loading.toggle();
      await _auth.signOut();
      Get.find<UserController>().clear();
      Get.offAllNamed(AppRouter.loginRoute);
      loading.toggle();
    } catch (e) {
      loading.toggle();
      displayError(e);
    }
  }
}
