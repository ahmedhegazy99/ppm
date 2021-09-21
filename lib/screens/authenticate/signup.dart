import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/background.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/components/dropDownButton.dart';
import 'package:pro_player_market/components/roundedButton.dart';
import 'package:pro_player_market/components/roundedInputField.dart';
import 'package:pro_player_market/controllers/authController.dart';
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
  var userType = UserTypeEnum.userPlayer.obs;

  var selectedDate = Rx(DateTime(DateTime.now().year - 15));

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      /*appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        /*title: Center(
          child: Image.asset(
            'assets/images/Hlogo.png',
            fit: BoxFit.contain,
            height: 100,
            width: 100,
          ),
        ),*/
        centerTitle: true,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
      ),*/
      resizeToAvoidBottomInset: true,
      body: Background(
        child: /*Obx((){
          return */
            SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                        groupValue: controller.userType.value,
                        activeColor: ppmMain,
                        onChanged: (UserTypeEnum? value) {
                          //userType = value!;
                          controller.userType.value = value!;
                        },
                      ),
                      Text("Player"),
                      Radio<UserTypeEnum>(
                        value: UserTypeEnum.club,
                        groupValue: controller.userType.value,
                        activeColor: ppmMain,
                        onChanged: (UserTypeEnum? value) {
                          //userType = value!;
                          controller.userType.value = value!;
                        },
                      ),
                      Text("Club"),
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
                  validator: (val) => val!.isEmpty ? 'Enter First Name' : null,
                  keyboardType: TextInputType.name,
                  hintText: "Full Name",
                  icon: Icons.account_circle,
                  controller: name,
                  color: Colors.grey[200]!,
                ),
                RoundedInputField(
                  validator: (val) => val!.isEmpty ? 'Enter an Email' : null,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Email",
                  icon: Icons.mail,
                  controller: email,
                  color: Colors.grey[200]!,
                ),
                RoundedInputField(
                  validator: (val) =>
                      val!.isEmpty ? 'Enter mobile number' : null,
                  keyboardType: TextInputType.phone,
                  hintText: "Mobile Number",
                  icon: Icons.phone,
                  controller: mobile,
                  color: Colors.grey[200]!,
                ),

                //SizedBox(height: size.height * 0.03),
                GestureDetector(
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
                    selectedDate = await selectDate(context);
                  },
                ),

                DropButton(
                  cSize: 0.7,
                  oWidth: 0.7,
                  controller: controller,
                ),

                RoundedInputField(
                  validator: (val) => val!.isEmpty ? 'Enter an password' : null,
                  textColor: Colors.black,
                  obscureText: true,
                  icon: Icons.lock,
                  color: Colors.grey[200]!,
                  hintText: "Password",
                  controller: password,
                ),

                //SizedBox(height: size.height * 0.03),

                RoundedInputField(
                  validator: (val) =>
                      val!.isEmpty ? "Password didn't match" : null,
                  textColor: Colors.black,
                  obscureText: true,
                  icon: Icons.lock,
                  color: Colors.grey[200]!,
                  hintText: "Confirm Password",
                  controller: confirmPassword,
                ),

                //SizedBox(height: size.height * 0.03),

                RoundedButton(
                    text: "sign up",
                    press: () async {
                      if (_formKey.currentState!.validate() &&
                          password.text == confirmPassword.text) {
                        controller.createUser(
                            name.text,
                            userType.value,
                            email.text,
                            mobile.text,
                            selectedDate.value,
                            password.text);
                      }
                    }),
              ],
            ),
          ),
          /*);
        }*/
        ),
      ),
    );
  }
}
