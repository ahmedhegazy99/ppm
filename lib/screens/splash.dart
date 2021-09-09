import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/controllers/authController.dart';
import 'package:pro_player_market/controllers/userController.dart';
import 'package:pro_player_market/utils/appRouter.dart';

class Splash extends StatelessWidget {
  void navigate() async {
    var controller = Get.find<AuthController>();

    await Future.delayed(Duration(seconds: 3));
    if (controller.user?.uid != null) {
      print("auth user not null");
      await _waitUntilDone();
      print("Done");
      Get.offAllNamed(AppRouter.mainBarRoute);
    }
    else {
      Get.offAllNamed(AppRouter.loginRoute);
    }
  }

  Future<void> _waitUntilDone() async {

    while(Get
        .find<UserController>()
        .user
        .userType == null){
      await 250.milliseconds.delay();
    }
/*
    final completer = Completer();
    if (Get
        .find<UserController>()
        .user
        .userType != null) {

      completer.complete();

    } else {
      print(Get
          .find<UserController>()
          .user
          .userType);
      await 200.milliseconds.delay();
      return _waitUntilDone();
    }
    return completer.future;*/
  }

  @override
  Widget build(BuildContext context) {
    navigate();
    return Container(
      color: ppmBack,
      child: Center(
          child: SizedBox(
          //height: 250.0,
            height: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Image.asset(
                  'assets/images/fpm.jpeg',
                  fit: BoxFit.contain,
                  height: 200,
                  width: 200,
                ),

                Text(
                  "Football Player"
                  "\nMarket",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "englishBebas",
                      color: ppmMain,
                      fontSize: 24,
                      decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          //Image.asset("assets/images/Hlogo.png")

         )
      ),
    );
  }
}
