// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pro_player_market/components/videoPlayer.dart';
// import 'package:pro_player_market/controllers/createPlayerController.dart';
//
// class SelectVideo extends GetWidget<CreatePlayerController> {
//
//   var selectedVideo ;
//   RxBool _done = false.obs;
//
//   //Key key = GlobalKey();
//   Key key = Key('key');
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return GestureDetector(
//       child: Container(
//         key: key,
//         child: _done.value?VideoWidget(
//           selectedVideo
//         ):Icon(Icons.video_stable,
//           size: size.width/2,
//         ),
//       ),
//       onTap: () async{
//         selectedVideo = await controller.selectVideo();
//         _done.value = true;
//       },
//     );
//   }
// }
