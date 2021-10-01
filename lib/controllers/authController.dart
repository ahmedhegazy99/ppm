import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/constants.dart';
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

  var city;

  @override
  void onReady() {
    _user.bindStream(_auth.authStateChanges());
    ever(_user, (User? _) async {
      if (_ != null) {
        Get.find<UserController>().user =
            await Get.find<DatabaseController>().getUser(_.uid);
        print("user auth : ${Get.find<UserController>().user}");
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

  void createUser(String name, UserTypeEnum userType, String email,
      String mobile, DateTime birthDate, String password) async {
    try {
      loading.toggle();
      UserCredential _authResult = /* AuthResult _authResult =*/ await _auth
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password);
      UserModel _user = UserModel(
        id: _authResult.user!.uid,
        name: name,
        userType: userType,
        mobile: mobile,
        email: email,
        joinDate: DateTime.now(),
        city: city,
        birthDate: birthDate,
      );
      _authResult.user!.updateDisplayName(name);
     // _authResult.user!.updatePhoneNumber(mobile);
      await Get.find<DatabaseController>().createNewUser(_user);
      //updateUserPhone(mobile);
      Get.offAllNamed(AppRouter.mainBarRoute);
      loading.toggle();
      Get.back();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      displayError(e.code);
    } catch (e) {
      loading.toggle();
      //displayError(e);
    }
  }

  /*void updateUser(String name, String email,
      String mobile) async {
    try {
      loading.toggle();
      UserModel _user = UserModel(
        name: name,
        mobile: mobile,
        email: email,
      );
      await Get.find<DatabaseController>().createNewUser(_user);
      Get.defaultDialog(
          title: 'Done'.tr, content: Icon(Icons.verified_rounded), backgroundColor: ppmMain
      );
      loading.toggle();
      Get.back();
    } catch (e) {
      loading.toggle();
      displayError(e);
    }
  }*/

  Future updateUserPhone(String phoneNumber) async {
    try{
      loading.toggle();
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(minutes: 2),
        verificationCompleted: (credential) async {
          await user!.updatePhoneNumber(credential);
          // either this occurs or the user needs to manually enter the SMS code
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }

        },
        codeSent: (verificationId, [forceResendingToken]) async {
          String smsCode = 'xxxx';
          // get the SMS code from the user somehow (probably using a text field)
          PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
          await user!.updatePhoneNumber(credential);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
        },
      );
     Get.defaultDialog(
         title: 'Done'.tr, content: Text("Phone Verified", style: TextStyle(color: ppmBack),), backgroundColor: ppmMain, titleStyle: TextStyle(color: ppmBack)
     );
     loading.toggle();
    } catch (e){

    }
  }

  Future updateUserPass(String password) async {
    try {
      loading.toggle();
      await _auth.currentUser!.updatePassword(password).then((val){
        // Password has been updated.
        Get.defaultDialog(
            title: 'Done'.tr, content: Text("Password Updated Successfully", style: TextStyle(color: ppmBack),), backgroundColor: ppmMain, titleStyle: TextStyle(color: ppmBack)
        );
      }).catchError((err){
        // An error has occured.
        Get.defaultDialog(
            title: 'Failed'.tr, content: Text("Can't Update Password\ntry again later", style: TextStyle(color: ppmBack),), backgroundColor: ppmLight, titleStyle: TextStyle(color: ppmBack)
        );
      });

      loading.toggle();
      Get.back();
    } catch (e) {
      loading.toggle();
      displayError(e);
    }
  }

  Future forgotPass(String email) async {
    try {
      loading.toggle();
      await _auth.sendPasswordResetEmail(email: email).then((val){
        // reset email has been sent.
        Get.defaultDialog(
            title: 'Done'.tr, content: Text("/Sent Password Reset Link to $email", style: TextStyle(color: ppmBack),), backgroundColor: ppmMain, titleStyle: TextStyle(color: ppmBack)
        );
      }).catchError((err){
        // An error has occured.
        Get.defaultDialog(
            title: 'Failed'.tr, content: Text("Can't send email\ntry again later", style: TextStyle(color: ppmBack),), backgroundColor: ppmLight, titleStyle: TextStyle(color: ppmBack)
        );
      });

      loading.toggle();
      Get.back();
    } catch (e) {
      loading.toggle();
      displayError(e);
    }
  }

  Future updateUserPhoto(String photo) async {
    try {
      loading.toggle();
      await _auth.currentUser!.updatePhotoURL(photo).then((val){
        // Pic has been updated.
        Get.defaultDialog(
            title: 'Done'.tr, content: Text("Photo Updated Successfully", style: TextStyle(color: ppmBack),), backgroundColor: ppmMain, titleStyle: TextStyle(color: ppmBack)
        );
      }).catchError((err){
        // An error has occured.
        Get.defaultDialog(
            title: 'Failed'.tr, content: Text("Can't Update Photo\ntry again later", style: TextStyle(color: ppmBack),), backgroundColor: ppmLight, titleStyle: TextStyle(color: ppmBack)
        );
      });

      loading.toggle();
      Get.back();
    } catch (e) {
      loading.toggle();
      displayError(e);
    }
  }

  Future login(String email, String password) async {
    try {
      loading.toggle();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed(AppRouter.mainBarRoute);
      // Get.offAllNamed(AppRouter.contactRoute);
      print("start");
      loading.toggle();
      print("finish");
    } on FirebaseAuthException catch (e) {
      loading.toggle();
      //displayError(e);
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
