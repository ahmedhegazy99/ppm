import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/background.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/components/roundedButton.dart';
import 'package:pro_player_market/components/roundedInputField.dart';
import 'package:pro_player_market/controllers/authController.dart';
import 'package:pro_player_market/controllers/mainBarController.dart';
import 'package:pro_player_market/utils/appRouter.dart';

class Login extends GetWidget<AuthController> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isVisible = false.obs;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: Background(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    leading: Image.asset(
                      'assets/images/fpm.png',
                      fit: BoxFit.contain,
                      height: 30,
                      width: 30,
                    ),
                    trailing: OutlinedButton.icon(
                      onPressed: (){
                        if(Get.locale == Locale('ar')){
                          Get.updateLocale(Locale('en'));
                        }else {
                          Get.updateLocale(Locale('ar'));
                        }
                        //Get.reset();
                        Get.find<MainBarController>().currentLocale.value = Get.locale;
                      },
                      label: Text('language'.tr),
                      icon: Icon(Icons.language, color: ppmMain,),
                    ),
                  ),
                  SizedBox(height: size.height * 0.2),
                  Text(
                    "LOGIN".tr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "englishBebas",
                        color: ppmMain,
                        fontSize: Get.locale == Locale('ar') ? 40 : 60,
                    ),
                  ),
                  Obx(() {
                    return Visibility(
                      visible: isVisible.value,
                      child: Text(
                        "you have entered wrong email or password".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "englishBebas",
                            color: Colors.red,
                            fontSize: 12),
                      ),
                    );
                  }),
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    validator: (val) => val!.isEmpty ? 'Enter an email'.tr : null,
                    keyboardType: TextInputType.emailAddress,
                    icon: Icons.person,
                    hintText: "email".tr,
                    color: Colors.grey[200]!,
                    controller: emailController,
                  ),
                  RoundedInputField(
                    validator: (val) => val!.isEmpty ? 'Enter an password'.tr : null,
                    color: Colors.grey[200]!,
                    textColor: Colors.black,
                    obscureText: true,
                    icon: Icons.lock,
                    hintText: "password".tr,
                    controller: passwordController,
                  ),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        if(emailController.text.isNotEmpty) {
                          Get.defaultDialog(
                            title: "Send Reset password Email to ${emailController
                                .text}",
                            confirm: ElevatedButton(
                                onPressed: () {
                                  controller.forgotPass(emailController.text);
                                },
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(
                                      ppmBack),
                                  backgroundColor: MaterialStateProperty.all(
                                      ppmMain),
                                ),
                                child: Text("Reset")
                            )
                          );
                        }else{
                          Get.defaultDialog(
                            title: "please enter an Email",
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          "Forgot Password?".tr,
                          style: TextStyle(color: ppmMain, fontSize: 12),
                        ),
                      ),
                    ),
                  ),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRouter.signupRoute);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          "you don't have an account? Sign Up.".tr,
                          style: TextStyle(color: ppmMain, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  RoundedButton(
                    text: "login".tr,
                    press: () async {
                      isVisible.value = false;
                      //to sign in with email and password
                      if (_formKey.currentState!.validate()) {
                        try{
                          await controller.login(
                              emailController.text, passwordController.text);
                        } catch(e){
                          isVisible.value = true;
                        }

                      }
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
