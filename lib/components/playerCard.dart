import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/controllers/databaseController.dart';
import 'package:pro_player_market/controllers/mainBarController.dart';
import 'package:pro_player_market/controllers/postController.dart';
import 'package:pro_player_market/controllers/userController.dart';
import 'package:pro_player_market/models/playerModel.dart';
import 'package:pro_player_market/models/userModel.dart';

class PlayerCard extends StatelessWidget {
  final PlayerModel ? post;
  PlayerCard({this.post});

  @override
  Widget build(BuildContext context) {
    final UserModel user = Get.find<UserController>().user;
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 5,
            ),
            child: ListTile(
              leading: GestureDetector(
                onTap: () {
                  Get.find<MainBarController>().openUserProfile(post!.userId!);
                },
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: NetworkImage(post!.userImage ??
                      'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png'),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${post!.userName}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    DateFormat.yMEd().format(post!.date!),
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.black38),
                  ),
                ],
              ),
              subtitle: Text('@${post!.userName}'),
              trailing: user.id == post!.userId
                  ? PopupMenuButton(
                      onSelected: (val) {
                        if (val == 'delete') {
                          Get.find<DatabaseController>().deletePost(post!.id!);
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text('delete'.tr),
                          value: 'delete',
                        )
                      ],
                    )
                  : null,
            ),
          ),
          // //post text
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: Row(
              children: [
                Text('${post!.text}'),
              ],
            ),
          ),

          // post image
          if (post!.type == PostTypeEnum.photo && post!.contentUrl != null)
            Container(
              child: Image.network('${post!.contentUrl}'),
            ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 0),
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton.icon(
                  icon: SvgPicture.asset(
                    "assets/icons/cart.svg",
                    // By default our  icon color is white
                    color: post!.upvotes?.contains(user.id) == true
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  label: Text(
                    '${'upvote'.tr} (${post!.upvotes?.length ?? '0'})',
                    style: TextStyle(
                      color: post!.upvotes?.contains(user.id) == true
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                  textColor: Colors.black38,
                  onPressed: () {
                    Get.find<PostController>().toggleIsLiked(post!);
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
