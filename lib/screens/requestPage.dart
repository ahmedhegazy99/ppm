import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/components/roundedButton.dart';
import 'package:pro_player_market/controllers/postController.dart';
import 'package:pro_player_market/controllers/requestsController.dart';
import 'package:pro_player_market/controllers/userController.dart';
import 'package:pro_player_market/models/playerModel.dart';
import 'package:pro_player_market/models/requestModel.dart';
import 'package:pro_player_market/models/userModel.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';

class RequestPage extends GetWidget<RequestsController>{

  final RequestModel ? request;
  final UserModel ? user;
  final PlayerModel ? player;
  RequestPage({this.request, this.user,this.player});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    controller.getUser(player!.userId!);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        //automaticallyImplyLeading: true,
        backgroundColor: ppmMain,
        centerTitle: true,

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: ppmLight,
          ),
          onPressed: () {
            Get.back();
          },
        ),

        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  //margin: EdgeInsets.only(bottom: 10, left: 10, top: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: Obx((){
                    return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Player",
                            style: TextStyle(
                                color: ppmMain,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),

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

                      if(player!.birthDate.isNull == false)
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

                      const Divider(height: 20.0, thickness: 0.5),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Contact info",
                          style: TextStyle(
                              color: ppmMain,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

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
                                    text: "${controller.pageUser?.name}",
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
                              text: "Phone: ",
                              style: TextStyle(
                                  color: ppmMain,
                                  fontWeight: FontWeight.bold
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "${controller.pageUser?.mobile}",
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
                                text: "Mail: ",
                                style: TextStyle(
                                    color: ppmMain,
                                    fontWeight: FontWeight.bold
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "${controller.pageUser?.email}",
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
                    );
                  }),
                ),

                SizedBox(
                  height: size.width * 0.04,
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Requester",
                            style: TextStyle(
                                color: ppmMain,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),

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
                                  text: "${user!.name}",
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
                              text: "Phone: ",
                              style: TextStyle(
                                  color: ppmMain,
                                  fontWeight: FontWeight.bold
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "${user!.mobile}",
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
                                text: "Mail: ",
                                style: TextStyle(
                                    color: ppmMain,
                                    fontWeight: FontWeight.bold
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "${user!.email}",
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
        ),
      ),
    );
  }
}
