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
  final mainColor = ppmMain;

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
                      radius: size.width * 0.2,
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

                          if (controller.userType == UserTypeEnum.club)
                            OutlinedButton(
                              onPressed: () {
                                print('Received click Requests');
                                //Get.offAllNamed(AppRouter.addPlayerRoute);
                              },
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all(ppmBack),
                                backgroundColor: MaterialStateProperty.all(ppmMain),
                              ),
                              child: const Text('Requests'),
                            ),

                          SizedBox(width: size.width * 0.01),

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
                              foregroundColor: MaterialStateProperty.all(ppmBack),
                              backgroundColor: MaterialStateProperty.all(ppmMain),
                            ),
                            child: const Text('Sell Player'),
                          ),
                        ]
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        //color: ppmMain,
                        /*borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40),
                        ),*/
                      ),
                      //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      padding: EdgeInsets.only(bottom: 20, left: 20, top: 20),
                      //margin: EdgeInsets.only(bottom: 10, left: 10, top: 10, right: 10),
                      child: Column(
                        children: [
                          Container(
                            width: size.width * 0.9,
                            //height: size.height * 0.2,
                            padding: EdgeInsets.only(bottom: 20),
                            child: Flex(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              direction: Axis.vertical,
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.person, color: mainColor,),
                                  title: Flex(
                                    direction: Axis.vertical,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Type",
                                        style: TextStyle(
                                          color: mainColor,
                                          fontSize: size.width * 0.03,
                                        ),
                                      ),
                                      Text(
                                        "${controller.userTypeSt ?? 'no data'}",
                                        style: TextStyle(
                                          color: ppmLight,
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.width * 0.04,
                                        ),
                                      ),
                                      const Divider(height: 20.0, thickness: 0.5),
                                    ]
                                  ),
                                ),

                                ListTile(
                                  leading: Icon(Icons.mail, color: mainColor,),
                                  trailing: IconButton(
                                      onPressed: (){

                                      },
                                      icon: Icon(Icons.edit),
                                  ),
                                  title: Flex(
                                      direction: Axis.vertical,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Mail",
                                          style: TextStyle(
                                            color: mainColor,
                                            fontSize: size.width * 0.03,
                                          ),
                                        ),
                                        Text(
                                          "${controller.user?.email ?? 'no data'}",
                                          style: TextStyle(
                                            color: ppmLight,
                                            fontWeight: FontWeight.bold,
                                            fontSize: size.width * 0.04,
                                          ),
                                        ),
                                        const Divider(height: 20.0, thickness: 0.5),
                                      ]
                                  ),
                                ),

                                ListTile(
                                  leading: Icon(Icons.phone, color: mainColor,),
                                  trailing: IconButton(
                                    onPressed: (){

                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                  title: Flex(
                                      direction: Axis.vertical,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Phone",
                                          style: TextStyle(
                                            color: mainColor,
                                            fontSize: size.width * 0.03,
                                          ),
                                        ),
                                        Text(
                                          "${controller.user?.mobile ?? 'no data'}",
                                          style: TextStyle(
                                            color: ppmLight,
                                            fontWeight: FontWeight.bold,
                                            fontSize: size.width * 0.04,
                                          ),
                                        ),
                                        const Divider(height: 20.0, thickness: 0.5),
                                      ]
                                  ),
                                ),
                              ]
                            ),
                          ),

                          /*OutlinedButton(
                            onPressed: () {
                              print('Received click Edit Data');
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(ppmBack),
                              backgroundColor: MaterialStateProperty.all(ppmMain),
                              fixedSize: MaterialStateProperty.all(Size(size.width * 0.6, size.width * 0.02)),
                              alignment: Alignment.center,
                            ),
                            child: const Text('Edit'),
                          ),*/

                        ],
                      ),
                    ),
                    if (controller.userType != UserTypeEnum.admin)
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
