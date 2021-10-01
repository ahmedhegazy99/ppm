import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/background.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/components/dropDownButton.dart';
import 'package:pro_player_market/components/roundedButton.dart';
import 'package:pro_player_market/components/roundedInputField.dart';
import 'package:pro_player_market/controllers/authController.dart';
import 'package:pro_player_market/controllers/mainBarController.dart';
import 'package:pro_player_market/models/userModel.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';

class Signup extends GetWidget<AuthController> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController mobile = TextEditingController();

  //UserTypeEnum userType = UserTypeEnum.userPlayer.obs as UserTypeEnum;
  //var userType = UserTypeEnum.userPlayer.obs;
  var userType = Rxn<UserTypeEnum>();

  var selectedDate = Rx(DateTime(DateTime.now().year - 15));

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: Background(
        child: /*Obx((){
          return */
            SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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

                  Text(
                    'signup'.tr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "englishBebas",
                        color: ppmMain,
                        fontSize: 60),
                  ),
                  SizedBox(height: size.height * 0.01),

                  Obx(() {
                    return Flex(
                      mainAxisAlignment: MainAxisAlignment.center,
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Radio<UserTypeEnum>(
                          value: UserTypeEnum.userPlayer,
                          //groupValue: controller.userType.value,
                          groupValue: userType.value,
                          activeColor: ppmMain,
                          onChanged: (UserTypeEnum? value) {
                            userType.value = value!;
                            //controller.userType.value = value!;
                          },
                        ),
                        Text("player".tr),
                        Radio<UserTypeEnum>(
                          value: UserTypeEnum.club,
                          //groupValue: controller.userType.value,
                          groupValue: userType.value,
                          activeColor: ppmMain,
                          onChanged: (UserTypeEnum? value) {
                            userType.value = value!;
                            //controller.userType.value = value!;
                          },
                        ),
                        Text("club".tr),
                        /*
                        Radio<UserTypeEnum>(
                          value: UserTypeEnum.admin,
                          groupValue: controller.userType.value,
                          activeColor: ppmMain,
                          onChanged: (UserTypeEnum? value) {
                            //userType = value!;
                            controller.userType.value = value!;
                          },
                        ),
                        Text("Admin"),
                        */
                      ],
                    );
                  }),

                  RoundedInputField(
                    validator: (val) => val!.isEmpty ? 'Enter Full Name'.tr : null,
                    keyboardType: TextInputType.name,
                    hintText: "Full Name".tr,
                    icon: Icons.account_circle,
                    controller: name,
                    color: Colors.grey[200]!,
                  ),
                  RoundedInputField(
                    validator: (val) {
                      if (val!.isEmpty)
                        return "Please enter email".tr;
                      else if (!val.contains("@"))
                        return "Please enter valid email".tr;
                      else
                        return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    hintText: "email".tr,
                    icon: Icons.mail,
                    controller: email,
                    color: Colors.grey[200]!,
                  ),
                  RoundedInputField(
                    validator: (val) =>
                        val!.isEmpty ? 'Enter mobile number'.tr : null,
                    keyboardType: TextInputType.phone,
                    hintText: "Mobile Number".tr,
                    icon: Icons.phone,
                    controller: mobile,
                    color: Colors.grey[200]!,
                  ),

                  //SizedBox(height: size.height * 0.03),
                  Obx((){
                    return GestureDetector(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.symmetric(horizontal: 48, vertical: 12),
                        height: size.width * 0.13,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: ppmBack,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: ppmMain
                                ),
                              ),
                              SizedBox(width: size.width * 0.02),

                              Icon(Icons.arrow_forward_ios, color: ppmMain,),
                            ]
                        ),
                      ),
                      onTap: () async {
                        print("select date clicked");
                        selectedDate.value = await selectDate(context);
                      },
                    );
                  }),

                  DropButton(
                    cSize: 0.7,
                    oWidth: 0.7,
                    controller: controller,
                  ),

                  RoundedInputField(
                    validator: (val) {
                      if (val!.isEmpty)
                        return "Please enter password".tr;
                      else if (val.length < 8)
                        return "Your password should is too short".tr;
                      else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(val))
                        return "Your password should match criteria".tr;
                      /*else
                        return null;*/
                    },
                    textColor: Colors.black,
                    obscureText: true,
                    icon: Icons.lock,
                    color: Colors.grey[200]!,
                    hintText: "password".tr,
                    controller: password,
                  ),

                  //SizedBox(height: size.height * 0.03),

                  RoundedInputField(
                    validator: (val) =>
                        val!.isEmpty ? "Password didn't match".tr : null,
                    textColor: Colors.black,
                    obscureText: true,
                    icon: Icons.lock,
                    color: Colors.grey[200]!,
                    hintText: "confirm password".tr,
                    controller: confirmPassword,
                  ),

                  Visibility(
                      visible: true,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 48,vertical: 8),
                        child: Text.rich(
                          TextSpan(
                              text: "*Your password should be 8 character or more\n*Your password should contains Capital & small letters\n*Your password should contains numbers & special characters".tr,
                            style: TextStyle(
                              color: ppmLight
                            )
                          ),
                          textAlign: TextAlign.start,
                        ),
                      )
                  ),

                  //SizedBox(height: size.height * 0.03),

                  RoundedButton(
                      text: "signup".tr,
                      press: () async {
                        print('signup clicked');
                        if (_formKey.currentState!.validate() &&
                            password.text == confirmPassword.text) {
                          print("will create user");
                          controller.createUser(
                              name.text,
                              userType.value!,
                              email.text,
                              mobile.text,
                              selectedDate.value,
                              password.text);
                        }
                      }),
                ],
              ),
            ),
          ),
          /*);
        }*/
        ),
      ),
    );
  }
}
