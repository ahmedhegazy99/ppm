import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/components/editPlayer.dart';
import 'package:pro_player_market/components/videoPlayer.dart';
import 'package:pro_player_market/controllers/createPlayerController.dart';
import 'package:pro_player_market/controllers/databaseController.dart';
import 'package:pro_player_market/controllers/postController.dart';
import 'package:pro_player_market/controllers/userController.dart';
import 'package:pro_player_market/models/playerModel.dart';
import 'package:pro_player_market/models/userModel.dart';
import 'package:pro_player_market/screens/playerPage.dart';

class PlayerCard extends StatelessWidget {
  final PlayerModel ? player;
  final UserModel ? owner;
  PlayerCard({this.player, this.owner});

  var media ;

  @override
  Widget build(BuildContext context) {
    final UserModel user = Get.find<UserController>().user;

    media = [
      Image.network('${player!.photo}'),
      VideoWidget(player!.video),
    ];
    Size size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, /*horizontal: 6*/),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        children: [
          // post image
          //if (player!.photo != null)
            Stack(
              children: [
                Container(
                  height: size.width*0.8,
                  width: size.width,
                  child: (){
                    //if(player!.photo != null)
                      return CachedNetworkImage(
                        fit: BoxFit.fill,
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            //CircularProgressIndicator(value: downloadProgress.progress),
                        LinearProgressIndicator(value: downloadProgress.progress),
                        /*placeholder: (context, url) => Container(
                            child: Container(child: CircularProgressIndicator(), height: size.width*0.8,
                              width: size.width,)),*/
                        imageUrl: '${player!.photo}',
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      );

                    //     Image.network(
                    //       player!.photo ?? 'assets/images/placeholder.jpg',
                    //   );
                    // return Placeholder(fallbackHeight: 400,fallbackWidth: 400);
                  }(),
                  //Image.network('${player!.photo}') ?? Placeholder(fallbackHeight: 400,fallbackWidth: 400),
                ),
                if((user.id == player!.userId && !player!.show!) || user.userType == UserTypeEnum.admin)
                  PopupMenuButton(
                    onSelected: (val) {
                      if (val == 'delete') {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete Player'.tr),
                              content: Text('Are you sure you want to delete player?'.tr),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('delete'.tr),
                                  onPressed: () async {
                                    await Get.find<DatabaseController>().deletePost(player!.id!);
                                    //Navigator.of(context).pop();
                                    Get.back();
                                  },
                                ),
                                TextButton(
                                  child: Text('cancel'.tr),
                                  onPressed: () {
                                    //Navigator.of(context).pop();
                                    Get.back();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }

                      if(val == 'edit'){
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: SimpleDialog(
                                //backgroundColor: Colors.grey[200],
                                title: Text('edit'.tr,textAlign: TextAlign.center,),
                                children: <Widget>[

                                  EditPlayer(player: player!),

                                  Flex(
                                    direction: Axis.horizontal,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if(player!.show != true)
                                        SimpleDialogOption(
                                          onPressed: () {
                                            Get.find<CreatePlayerController>().updatePlayer(player!);
                                          },
                                          child: Text('edit'.tr),
                                        ),

                                      SimpleDialogOption(
                                        onPressed: () {Get.back();},
                                        child: Text('cancel'.tr),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }
                        );
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text('delete'.tr),
                        value: 'delete',
                      ),
                      PopupMenuItem(
                        child: Text('edit'.tr),
                        value: 'edit',
                      ),
                    ],
                  ),
              ]
            ),

          // post video
          /*if (post!.video != null)
            Container(
              child: VideoWidget(post!.video!),
            ),*/

          //name and city
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.only(bottom: 10, left: 10, top: 10, right: 10),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${player!.name}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  ', ${player!.city}',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black38),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 0),
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton.icon(
                  icon: Icon(
                    Icons.arrow_upward,
                    color: player!.upvotes?.contains(user.id) == true
                        ? ppmMain
                        : ppmLight,
                  ),
                  label: Text(
                    '${'like'.tr} ${player!.upvotes?.length ?? '0'}',
                    style: TextStyle(
                      color: player!.upvotes?.contains(user.id) == true
                          ? ppmMain
                          : ppmLight,
                    ),
                  ),
                  textColor: Colors.black38,
                  onPressed: () {
                    Get.find<PostController>().toggleIsLiked(player!);
                  },
                ),

                FlatButton(
                  child: Text(
                    'view more'.tr,
                    style: TextStyle(
                      color: ppmLight,
                    ),
                  ),
                  textColor: Colors.black38,
                  onPressed: () {
                    Get.to(PlayerPage(player: player!, owner: owner,));
                    //Get.find<MainBarController>().openPlayerProfile(post!.id!);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
