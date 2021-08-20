import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/background.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/components/roundedButton.dart';
import 'package:pro_player_market/components/roundedInputField.dart';
import 'package:pro_player_market/controllers/databaseController.dart';
import 'package:pro_player_market/controllers/userController.dart';
import 'package:pro_player_market/models/playerModel.dart';
import 'package:pro_player_market/models/userModel.dart';

class UploadPost extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Center(
          child: Image.asset(
            'assets/images/Hlogo.png',
            fit: BoxFit.contain,
            height: 100,
            width: 100,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Write Post",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "englishBebas",
                      color: ppmMain,
                      fontSize: 20),
                ),

                SizedBox(height: size.height * 0.01),

                RoundedInputField(
                  validator: (val) => val!.isEmpty ? 'write post...' : null,
                  keyboardType: TextInputType.name,
                  hintText: "post",
                  controller: description,
                ),

                //SizedBox(height: size.height * 0.03),

                RoundedButton(
                    text: "addPost".tr,
                    press: () async {
                      UserModel user = Get.find<UserController>().user;
                      Get.find<DatabaseController>().addPost(PlayerModel(
                        contentUrl: '',
                        date: DateTime.now(),
                        text: description.text,
                        type: PostTypeEnum.photo,
                        userId: user.id,
                        userImage: user.imageUrl,
                        userName: '${user.name}',
                      ));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
