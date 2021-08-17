// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class CreatePost extends StatelessWidget {
//   final controller = Get.put(CreatepostController());
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(16),
//       padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Stack(
//                 children: [
//                   CircleAvatar(
//                     radius: 20.0,
//                     backgroundColor: Color(0xFF1777F2),
//                     child: CircleAvatar(
//                       radius: 20.0,
//                       backgroundColor: Colors.grey[200],
//                       backgroundImage: NetworkImage(Get.find<UserController>()
//                               .user
//                               .imageUrl ??
//                           "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png"),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(width: 20.0),
//               Expanded(
//                 child: TextField(
//                   controller: controller.textController,
//                   decoration: InputDecoration.collapsed(
//                     hintText: 'whatIsInYourMind'.tr,
//                   ),
//                 ),
//               )
//             ],
//           ),
//           Obx(() {
//             if (controller.image.value != null)
//               return Column(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.all(16),
//                     child: Image.file(controller.image.value),
//                   ),
//                   RaisedButton(
//                     onPressed: () => controller.removeImage(),
//                     child: Text('remove'.tr),
//                   )
//                 ],
//               );
//             return SizedBox();
//           }),
//           const Divider(height: 20.0, thickness: 0.5),
//           Container(
//             height: 40.0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 FlatButton.icon(
//                   onPressed: () async {
//                     await controller.selectImage();
//                   },
//                   icon: const Icon(
//                     Icons.photo_library,
//                     color: Colors.lightGreen,
//                     size: 20,
//                   ),
//                   label: Text('image'.tr),
//                 ),
//                 const VerticalDivider(width: 8.0),
//                 FlatButton.icon(
//                   onPressed: () async {
//                     await controller.postPost();
//                   },
//                   icon: const Icon(
//                     Icons.share,
//                     color: Colors.deepPurpleAccent,
//                     size: 20,
//                   ),
//                   label: Text('post'.tr),
//                 ),
//               ],
//             ),
//           ),
//           GetX<DatabaseController>(
//             init: DatabaseController(),
//             builder: (controller) {
//               if (controller.uploading.value) return LinearProgressIndicator();
//               return Container();
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
