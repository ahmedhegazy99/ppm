import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/components/roundedButton.dart';
import 'package:pro_player_market/components/videoPlayer.dart';
import 'package:pro_player_market/controllers/databaseController.dart';
import 'package:pro_player_market/controllers/postController.dart';
import 'package:pro_player_market/controllers/userController.dart';
import 'package:pro_player_market/models/playerModel.dart';
import 'package:pro_player_market/models/userModel.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';

class PlayerPage extends GetWidget<PostController>{
  //const PlayerPage({Key? key}) : super(key: key);

  final PlayerModel ? player;
  final UserModel? owner;
  PlayerPage({this.player, this.owner});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[

            SliverAppBar(
              expandedHeight: 300.0,
              flexibleSpace: FlexibleSpaceBar(
                //title: Text('Available seats'),
                background: Image.network(
                  '${player!.photo}',
                  fit: BoxFit.cover,
                ),
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
                          text: "bio".tr,
                          style: TextStyle(
                              color: ppmMain,
                              fontWeight: FontWeight.bold
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "\n\t ${player!.bio}",
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
                    height: size.width * 0.02,
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
                              text: "name".tr,
                              style: TextStyle(
                                  color: ppmMain,
                                  fontWeight: FontWeight.bold
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ": ${player!.name}",
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
                                text: "city".tr,
                                style: TextStyle(
                                    color: ppmMain,
                                    fontWeight: FontWeight.bold
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ": ${player!.city}",
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
                                text: "age".tr,
                                style: TextStyle(
                                    color: ppmMain,
                                    fontWeight: FontWeight.bold
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ": ${calculateAge(player!.birthDate!)}",
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

                        //extra data for admin
                        if(controller.userType.value == UserTypeEnum.admin)
                        Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(kDefaultPadding),
                                child: Text.rich(
                                  TextSpan(
                                      text: "Join Date".tr,
                                      style: TextStyle(
                                          color: ppmMain,
                                          fontWeight: FontWeight.bold
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ": ${player!.joinDate!.day}/${player!.joinDate!.month}/${player!.joinDate!.year}",
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
                              /// add owner data
                              Center(
                                child: Text(
                                  "Contact info".tr,
                                  style: TextStyle(
                                      color: ppmMain,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),

                              const Divider(height: 20.0, thickness: 0.5),

                              Padding(
                                padding: const EdgeInsets.all(kDefaultPadding),
                                child: Text.rich(
                                  TextSpan(
                                      text: "name".tr,
                                      style: TextStyle(
                                          color: ppmMain,
                                          fontWeight: FontWeight.bold
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ": ${owner!.name}",
                                          style: TextStyle(
                                              color: ppmLight,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ]
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(kDefaultPadding),
                                child: Text.rich(
                                  TextSpan(
                                      text: "phone".tr,
                                      style: TextStyle(
                                          color: ppmMain,
                                          fontWeight: FontWeight.bold
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ": ${owner!.mobile}",
                                          style: TextStyle(
                                              color: ppmLight,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ]
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(kDefaultPadding),
                                child: Text.rich(
                                  TextSpan(
                                      text: "email".tr,
                                      style: TextStyle(
                                          color: ppmMain,
                                          fontWeight: FontWeight.bold
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ": ${owner!.email}",
                                          style: TextStyle(
                                              color: ppmLight,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ]
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(kDefaultPadding),
                                child: Text.rich(
                                  TextSpan(
                                      text: "type".tr,
                                      style: TextStyle(
                                          color: ppmMain,
                                          fontWeight: FontWeight.bold
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ": ${controller.getUserType(owner!)}",
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

                  if(player!.userId != Get.find<UserController>().user.id)
                  if (controller.userType.value == UserTypeEnum.club)
                   RoundedButton(
                      text: "Request Deal".tr,
                      press: () async {
                        UserModel user = Get.find<UserController>().user;
                        print("user on click : $user");
                        if(user.requests?.contains(player!.id) == false || user.requests == null) {
                          controller.BuyRequest(player!.id!);
                          if (user.requests == null) {
                            user.requests = [];
                          }
                          user.requests!.add(player!.id!);
                          Get.find<DatabaseController>().updateUser(user.id!, {'requests' : user.requests!});
                          if (player!.upvotes?.contains(user.id) == false) {
                            controller.toggleIsLiked(player!);
                          }
                          Get.defaultDialog(
                              title: 'success'.tr,
                              content: Icon(Icons.verified_rounded,color: ppmBack,),
                              backgroundColor: ppmMain, titleStyle: TextStyle(color: ppmBack)
                          );
                        }else{
                          Get.defaultDialog(
                            title: "Can't Request".tr,
                            content: Text("You already submitted a request".tr,style: TextStyle(color: ppmBack),),
                            backgroundColor: ppmLight,
                            titleStyle: TextStyle(color: ppmBack)
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
