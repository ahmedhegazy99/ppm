import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/components/playerCard.dart';
import 'package:pro_player_market/controllers/mainBarController.dart';
import 'package:pro_player_market/controllers/profileController.dart';
import 'package:pro_player_market/utils/appRouter.dart';

class Profile extends GetWidget<ProfileController> {

  //final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //String? userId = controller.userId;
    String userId = Get.find<MainBarController>().userId.value;
    //controller = Get.put(ProfileController(userId: userId));
    //controller.userId = userId;
    //if(Get.find<MainBarController>().userId != null) {
      controller.userId = Get.find<MainBarController>().userId;
      controller.onInit();
    //}
    return Scaffold(
      backgroundColor: Colors.grey[200],

      body: Container(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Obx(() {
              if (controller.loading.value) {
                return Container(
                    height: Get.height,
                    child: Center(child: CircularProgressIndicator()));
              }
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(controller.user?.imageUrl ??
                          'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png'),
                      radius: 40,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      controller.user!.name ?? 'no data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: ppmLight,
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    //if (userId == null)
                      /*RoundedButton(
                        text: "Log Out",
                        color: Colors.red,
                        textColor: Colors.white,
                        press: () async {
                          Get.find<AuthController>().signOut();
                        },
                      ),*/
                    Container(
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        color: ppmMain,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40),
                        ),
                      ),
                      child: Flex(
                        mainAxisAlignment: MainAxisAlignment.center,
                        direction: Axis.horizontal,
                        children: <Widget>[
                          OutlinedButton(
                            onPressed: () {
                              print('Received click Requests');
                              //Get.offAllNamed(AppRouter.addPlayerRoute);
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(ppmMain),
                            ),
                            child: const Text('Requests'),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              print('Received click sell player');
                              Get.toNamed(AppRouter.addPlayerRoute);
                              //Get.offAllNamed(AppRouter.addPlayerRoute);
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(ppmMain),
                            ),
                            child: const Text('Sell Player'),
                          ),
                        ]
                      ),
                    ),

                    ...controller.posts.value
                        .map((e) => PlayerCard(
                              player: e,
                            ))
                        .toList(),

                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
