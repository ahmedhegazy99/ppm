import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/components/roundedButton.dart';
import 'package:pro_player_market/controllers/databaseController.dart';
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
        title: Text("Football Player Market"),
        centerTitle: true,

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: ppmBack,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            //padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Column(
              children: [
                //Player
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  //margin: EdgeInsets.only(bottom: 10, left: 10, top: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                   /* borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),*/
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
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.06,
                            ),
                          ),
                        ),
                      ),

                      // post image
                      if (player!.photo != null)
                        Container(
                          child: (){
                            if(player!.photo != null)
                              return Image.network('${player!.photo}');
                            return Placeholder(fallbackHeight: 400,fallbackWidth: 400);
                          }(),
                          //Image.network('${player!.photo}') ?? Placeholder(fallbackHeight: 400,fallbackWidth: 400),
                        ),

                      Padding(
                        padding: const EdgeInsets.all(kDefaultPadding/4),
                        child: ListTile(
                           leading: Icon(Icons.person, color: ppmMain,),
                            title: Text.rich(
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
                      ),

                      Padding(
                        padding: const EdgeInsets.all(kDefaultPadding/4),
                        child: ListTile(
                            leading: Icon(Icons.location_on, color: ppmMain,),
                            title: Text.rich(
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
                      ),

                      if(player!.birthDate.isNull == false)
                        Padding(
                          padding: const EdgeInsets.all(kDefaultPadding/4),
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

                        Padding(
                          padding: const EdgeInsets.all(kDefaultPadding/4),
                          child: Text.rich(
                            TextSpan(
                                text: "Bio: \n",
                                style: TextStyle(
                                    color: ppmMain,
                                    fontWeight: FontWeight.bold
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "\t ${player!.bio}",
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
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        child: Text(
                          "Contact info",
                          style: TextStyle(
                              color: ppmMain,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: ListTile(
                            leading: Icon(Icons.person, color: ppmMain,),
                            title: Text.rich(
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
                      ),

                      //const Divider(height: 20.0, thickness: 0.5),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: ListTile(
                            leading: Icon(Icons.phone, color: ppmMain,),
                            title: Text.rich(
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
                      ),

                      //const Divider(height: 20.0, thickness: 0.5),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                          child: ListTile(
                              leading: Icon(Icons.mail, color: ppmMain,),
                              title: Text.rich(
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
                        ),
                      ],
                    );
                  }),
                ),

                SizedBox(
                  height: size.width * 0.04,
                ),

                //Requester
                if(request!.type == RequestTypeEnum.deal)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    /*borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),*/
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
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.06,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(kDefaultPadding/4),
                        child: ListTile(
                           leading: Icon(Icons.person, color: ppmMain,),
                           title: Text.rich(
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
                      ),

                      //const Divider(height: 20.0, thickness: 0.5),

                      Padding(
                        padding: const EdgeInsets.all(kDefaultPadding/4),
                        child:ListTile(
                            leading: Icon(Icons.phone, color: ppmMain,),
                            title: Text.rich(
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
                      ),

                      //const Divider(height: 20.0, thickness: 0.5),

                        Padding(
                          padding: const EdgeInsets.all(kDefaultPadding/4),
                          child: ListTile(
                             leading: Icon(Icons.mail, color: ppmMain,),
                             title: Text.rich(
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
                        ),
                    ],
                  ),
                ),

                SizedBox(
                  height: size.width * 0.04,
                ),

                //For Admin post Approve
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    /*borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),*/
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      RoundedButton(
                          text: "Approve",
                          press: () async {
                            if(request!.type == RequestTypeEnum.deal){
                              await Get.find<DatabaseController>().approveDealRequest(
                                  request!.id!, request!.userId!);
                              Get.back();
                            }else {
                              PlayerModel post = player!;
                              await Get.find<DatabaseController>()
                                  .approvePlayerRequest(
                                  post, request!.id!, request!.userId!);
                              Get.back();
                            }
                          }
                      ),

                      RoundedButton(
                          text: "Decline",
                          press: () async {
                            if(request!.type == RequestTypeEnum.deal){
                              await Get.find<DatabaseController>().declineDealRequest(
                                  request!.id!, request!.userId!);
                              Get.back();
                            }else {
                              await Get.find<DatabaseController>().declinePlayerRequest(
                                  request!.id!, request!.userId!);
                              Get.back();
                            }
                          }
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
