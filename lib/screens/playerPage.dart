import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/components/roundedButton.dart';
import 'package:pro_player_market/components/videoPlayer.dart';
import 'package:pro_player_market/controllers/postController.dart';
import 'package:pro_player_market/controllers/userController.dart';
import 'package:pro_player_market/models/playerModel.dart';
import 'package:pro_player_market/models/userModel.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';

class PlayerPage extends GetWidget<PostController>{
  //const PlayerPage({Key? key}) : super(key: key);

  final PlayerModel ? player;
  PlayerPage({this.player});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ppmLight,
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[

            SliverAppBar(
              expandedHeight: 150.0,
              flexibleSpace: FlexibleSpaceBar(
                //title: Text('Available seats'),
                background: Image.network('${player!.photo}'),
              ),
              backgroundColor: ppmMain,
              /*actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.add_circle),
                  tooltip: 'Add new entry',
                  onPressed: () { /* ... */ },
                ),
              ]*/
            ),

             SliverToBoxAdapter(
               child: Container(
                child: Column(
                  children: [



                  Container(
                    alignment: Alignment.centerLeft,
                    color: Colors.white,
                    width: size.width ,
                    child: Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: RichText(
                        text: TextSpan(
                          text: "Bio\n",
                          style: TextStyle(
                              color: ppmMain,
                              fontWeight: FontWeight.bold
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "\t ${player!.bio}",
                              style: TextStyle(
                                  color: ppmLight,
                                  fontWeight: FontWeight.w500
                              ),
                            )
                          ],
                        )
                      ),
                    )
                  ),

                  SizedBox(
                    height: size.width * 0.04,
                  ),

                  Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          child: Text.rich(
                            TextSpan(
                              text: "Name: ",
                              style: TextStyle(
                                  color: ppmMain,
                                  fontWeight: FontWeight.bold
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "${player!.name}",
                                  style: TextStyle(
                                      color: ppmLight,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ]
                            ),
                          ),
                        ),

                        const Divider(height: 20.0, thickness: 0.5),

                        Padding(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          child: Text.rich(
                            TextSpan(
                                text: "City: ",
                                style: TextStyle(
                                    color: ppmMain,
                                    fontWeight: FontWeight.bold
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "${player!.city}",
                                    style: TextStyle(
                                        color: ppmLight,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ),

                        const Divider(height: 20.0, thickness: 0.5),

                        if(player!.birthDate != null)
                        Padding(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          child: Text.rich(
                            TextSpan(
                                text: "Age: ",
                                style: TextStyle(
                                    color: ppmMain,
                                    fontWeight: FontWeight.bold
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "${calculateAge(player!.birthDate!)}",
                                    style: TextStyle(
                                        color: ppmLight,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                    SizedBox(
                      height: 10,
                    ),

                    if (player!.video != null)
                      Container(
                        child: VideoWidget(player!.video!),
                      ),

                    SizedBox(
                      height: 10,
                    ),

                  if (controller.userType == UserTypeEnum.club)
                   RoundedButton(
                      text: "Request Deal",
                      press: () async {
                        UserModel user = Get.find<UserController>().user;
                        if(user.requests?.contains(player!.id) == false || user.requests == null) {
                          controller.BuyRequest(player!.id!);
                          if (user.requests == null) {
                            user.requests = [];
                          }
                          user.requests!.add(player!.id!);
                          Get.find<PostController>().toggleIsLiked(player!);
                        }else{
                          Get.defaultDialog(
                            title: "Can't Request".tr,
                            content: Text("You already submitted a request"),
                            backgroundColor: ppmLight
                          );
                        }
                      }
                    ),
                  ],
                ),
            ),
             ),
          ],
        ),
      ),
    );
  }
}
