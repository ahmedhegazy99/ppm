import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/components/videoPlayer.dart';
import 'package:pro_player_market/controllers/databaseController.dart';
import 'package:pro_player_market/controllers/mainBarController.dart';
import 'package:pro_player_market/controllers/postController.dart';
import 'package:pro_player_market/controllers/userController.dart';
import 'package:pro_player_market/models/playerModel.dart';
import 'package:pro_player_market/models/userModel.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:pro_player_market/screens/playerPage.dart';

class PlayerCard extends StatelessWidget {
  final PlayerModel ? player;
  PlayerCard({this.player});

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
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      child: Column(
        children: [
          // post image
          if (player!.photo != null)
            Container(
              //height: size.height * 0.65,
              child: (){
                //if(player!.photo != null)
                  return CachedNetworkImage(
                    placeholder: (context, url) => Container(child: CircularProgressIndicator(), width: 500, height: 400,),
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

          // post video
          /*if (post!.video != null)
            Container(
              child: VideoWidget(post!.video!),
            ),*/
/*
          PhotoViewGallery.builder(
            itemCount: 2,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions.customChild(
                child: Container(
                  //width: 300,
                  //height: 300,
                  child: media[index],
                ),
                //childSize: const Size(300, 300),
                //initialScale: PhotoViewComputedScale.contained,
                minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
                maxScale: PhotoViewComputedScale.covered * 4.1,
                //heroAttributes: PhotoViewHeroAttributes(tag: item.id),
              );
            },
            scrollPhysics: BouncingScrollPhysics(),
            backgroundDecoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
            ),
            /*loadingChild: Center(
              child: CircularProgressIndicator(),
            ),*/
          ),
*/

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
                    '${'upvote'.tr} ${player!.upvotes?.length ?? '0'}',
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
                    Get.to(PlayerPage(player: player!));
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
