import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/components/playerCard.dart';
import 'package:pro_player_market/controllers/mainBarController.dart';
import 'package:pro_player_market/controllers/profileController.dart';
import 'package:pro_player_market/models/userModel.dart';
import 'package:pro_player_market/screens/requests.dart';
import 'package:pro_player_market/utils/appRouter.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Profile extends GetWidget<ProfileController> {

  final controller = Get.put(ProfileController());
  final mainColor = ppmMain;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
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
                  GestureDetector(
                    child: Stack(
                      children: [

                        CachedNetworkImage(
                          imageUrl: '${controller.user?.imageUrl ??'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png' }',
                          imageBuilder: (context, imageProvider) => Container(
                            width: size.width * 0.4,
                            height: size.width * 0.4,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => CircleAvatar(
                            backgroundImage:
                            NetworkImage('https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png'),
                            radius: size.width * 0.2,
                            ),
                        ),

                        /*CircleAvatar(
                          // child: CachedNetworkImage(
                          //   placeholder: (context, url) => CircularProgressIndicator(),
                          //   imageUrl: 'https://picsum.photos/250?image=9',
                          // ),
                          backgroundImage: controller.user?.imageUrl != null ?
                          NetworkImage('${controller.user?.imageUrl}')
                              : NetworkImage('https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png'),
                          radius: size.width * 0.2,
                        ),*/
                        Positioned(
                          top: size.width * 0.28,
                          left: size.width * 0.28,
                          child: CircleAvatar(
                            backgroundColor: ppmMain,
                            child:  Icon(Icons.photo_camera, color: ppmBack,)
                          ),
                        ),
                      ]
                    ),
                    onTap: () async{
                      await controller.updateUserPhoto();
                    },
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
                              Get.to(Requests());
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(ppmBack),
                              backgroundColor: MaterialStateProperty.all(ppmMain),
                            ),
                            child: Text('requests'.tr),
                          ),

                        if (controller.userType == UserTypeEnum.admin)
                          OutlinedButton(
                            onPressed: () {
                              print('Received click cities');
                              controller.showSheet(context, "cities");
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(ppmBack),
                              backgroundColor: MaterialStateProperty.all(ppmMain),
                            ),
                            child: Text('cities'.tr),
                          ),

                        SizedBox(width: size.width * 0.01),

                        OutlinedButton(
                          onPressed: () {
                            print('Received click sell player');
                            print(controller.userType);
                            if (controller.userType == UserTypeEnum.userPlayer){
                              if (controller.user!.requests != null)
                                Get.snackbar("Can't sell player", "You arent allowed to sell more players");
                              else
                                Get.toNamed(AppRouter.addPlayerRoute);
                            }else {
                              Get.toNamed(AppRouter.addPlayerRoute);
                            }
                          },
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(ppmBack),
                            backgroundColor: MaterialStateProperty.all(ppmMain),
                          ),
                          child: Text('sell player'.tr),
                        ),
                      ]
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(bottom: 20, top: 20),
                    //margin: EdgeInsets.only(bottom: 10, left: 10, top: 10, right: 10),
                    child: Column(
                      children: [
                        Container(
                          width: size.width /* 0.9*/,
                          //height: size.height * 0.2,
                          padding: EdgeInsets.only(bottom: 20, left: 20),
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
                                      "type".tr,
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
                                      print('Received click edit email');
                                      controller.showSheet(context, "email");
                                    },
                                    icon: Icon(Icons.edit),
                                ),
                                title: Flex(
                                    direction: Axis.vertical,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "email".tr,
                                        style: TextStyle(
                                          color: mainColor,
                                          fontSize: size.width * 0.03,
                                        ),
                                      ),
                                      Flex(
                                        direction: Axis.horizontal,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children:[
                                          Flexible(
                                            flex: 4,
                                            child: Text(
                                              "${controller.user?.email ?? 'no data'}",
                                              style: TextStyle(
                                                color: ppmLight,
                                                fontWeight: FontWeight.bold,
                                                fontSize: size.width * 0.04,
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Icon(Icons.verified,
                                              semanticLabel: controller.fireUser!.emailVerified == false ? "Verify" :"" ,
                                              color: controller.fireUser!.emailVerified == false  ? ppmLight : ppmMain,
                                            ),
                                          ),
                                          ]
                                      ),
                                      const Divider(height: 20.0, thickness: 0.5),
                                    ]
                                ),
                              ),

                              ListTile(
                                leading: Icon(Icons.phone, color: mainColor,),
                                trailing: IconButton(
                                  onPressed: (){
                                    print('Received click edit mobile');
                                    controller.showSheet(context, "mobile");
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                                title: Flex(
                                    direction: Axis.vertical,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "phone".tr,
                                        style: TextStyle(
                                          color: mainColor,
                                          fontSize: size.width * 0.03,
                                        ),
                                      ),
                                      Flex(
                                        direction: Axis.horizontal,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children:[
                                          Text(
                                            "${controller.user?.mobile ?? 'no data'}",
                                            style: TextStyle(
                                              color: ppmLight,
                                              fontWeight: FontWeight.bold,
                                              fontSize: size.width * 0.04,
                                            ),
                                          ),

                                          Icon(Icons.verified,
                                            semanticLabel: controller.fireUser?.phoneNumber == null ? "Verify" :"" ,
                                            color: controller.fireUser?.phoneNumber == null ? ppmLight : ppmMain,
                                          ),
                                        ]
                                      ),

                                      const Divider(height: 20.0, thickness: 0.5),
                                    ]
                                ),
                              ),

                              ListTile(
                                leading: Icon(Icons.location_on, color: mainColor,),
                                // trailing: IconButton(
                                //   onPressed: (){
                                //     print('Received click edit mobile');
                                //     controller.showSheet(context, "mobile");
                                //   },
                                //   icon: Icon(Icons.edit),
                                // ),
                                title: Flex(
                                    direction: Axis.vertical,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "city".tr,
                                        style: TextStyle(
                                          color: mainColor,
                                          fontSize: size.width * 0.03,
                                        ),
                                      ),
                                      Flex(
                                          direction: Axis.horizontal,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children:[
                                            Text(
                                              "${controller.user?.city ?? 'no data'}",
                                              style: TextStyle(
                                                color: ppmLight,
                                                fontWeight: FontWeight.bold,
                                                fontSize: size.width * 0.04,
                                              ),
                                            ),

                                            // Icon(Icons.verified,
                                            //   semanticLabel: controller.fireUser!.phoneNumber!.isEmpty ? "Verify" :"" ,
                                            //   color: controller.fireUser!.phoneNumber!.isEmpty ? ppmLight : ppmMain,
                                            // ),
                                          ]
                                      ),

                                      const Divider(height: 20.0, thickness: 0.5),
                                    ]
                                ),
                              ),

                              if(controller.user!.birthDate != null)
                              ListTile(
                                leading: Icon(Icons.calendar_today, color: mainColor,),
                                title: Flex(
                                    direction: Axis.vertical,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "birthdate".tr,
                                        style: TextStyle(
                                          color: mainColor,
                                          fontSize: size.width * 0.03,
                                        ),
                                      ),
                                      Flex(
                                          direction: Axis.horizontal,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children:[
                                            Text(
                                              //"${controller.user?.birthDate?? 'no data'}",
                                              "${controller.user!.birthDate!.day}/${controller.user!.birthDate!.month}/${controller.user!.birthDate!.year}",
                                              style: TextStyle(
                                                color: ppmLight,
                                                fontWeight: FontWeight.bold,
                                                fontSize: size.width * 0.04,
                                              ),
                                            ),
                                          ]
                                      ),

                                      const Divider(height: 20.0, thickness: 0.5),
                                    ]
                                ),
                              ),

                            ]
                          ),
                        ),

                        OutlinedButton(
                          onPressed: () {
                            print('Received click update password');
                            controller.showSheet(context, "password");
                          },
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(ppmBack),
                            backgroundColor: MaterialStateProperty.all(ppmMain),
                            fixedSize: MaterialStateProperty.all(Size(size.width * 0.6, size.width * 0.02)),
                            alignment: Alignment.center,
                          ),
                          child: Text('update password'.tr),
                        ),

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
    );
  }
}
