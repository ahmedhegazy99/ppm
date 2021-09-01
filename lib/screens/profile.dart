import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/components/playerCard.dart';
import 'package:pro_player_market/controllers/mainBarController.dart';
import 'package:pro_player_market/controllers/profileController.dart';
import 'package:pro_player_market/models/userModel.dart';
import 'package:pro_player_market/utils/appRouter.dart';

class Profile extends StatelessWidget {

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                      controller.user?.name ?? 'no data',
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
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40),
                        ),
                      ),
                      child: Flex(
                        mainAxisAlignment: MainAxisAlignment.center,
                        direction: Axis.horizontal,
                        children: <Widget>[

                          if (controller.userType != UserTypeEnum.userPlayer)
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
                              if (controller.userType == UserTypeEnum.userPlayer){
                                Get.snackbar("Can't sell player", "You arent allowed to sell more players");
                              }else {
                                Get.toNamed(AppRouter.addPlayerRoute);
                              }
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(ppmMain),
                            ),
                            child: const Text('Sell Player'),
                          ),
                        ]
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: ppmMain,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      margin: EdgeInsets.only(bottom: 10, left: 10, top: 10, right: 10),
                      child: Column(
                        children: [
                          Container(
                            width: size.width * 0.9,
                            height: size.height * 0.2,
                            child: Flex(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              direction: Axis.vertical,
                              children: <Widget>[
                                Text(
                                  "${controller.userTypeSt ?? 'no data'}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),

                                Text(
                                  "${controller.user?.email ?? 'no data'}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),

                                Text(
                                  "${controller.user?.mobile ?? 'no data'}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),

                              ]
                            ),
                          ),

                          OutlinedButton(
                            onPressed: () {
                              print('Received click Edit Data');
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(Colors.white),
                              fixedSize: MaterialStateProperty.all(Size(size.width * 0.6, size.width * 0.02)),
                              alignment: Alignment.center,
                            ),
                            child: const Text('Edit'),
                          ),

                        ],
                      ),
                    ),

                    if(controller.posts.value.isNotEmpty)
                      ...controller.posts.value
                          .map((e) => PlayerCard(
                                player: e,
                              ))
                          .toList(),

                    if(controller.posts.value.isEmpty)
                      Text("You haven't Requested Yet"),

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
