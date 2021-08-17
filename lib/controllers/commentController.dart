// import 'package:Minders/controllers/databaseController.dart';
// import 'package:Minders/models/replyModel.dart';
// import 'package:Minders/utils/utilFunctions.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// class CommentController extends GetxController {
//   var _commentsStream = Rx<List<ReplyModel>>();
//   List<ReplyModel> get comments => _commentsStream.value;
//
//   final postId;
//   CommentController({@required this.postId});
//
//   @override
//   void onInit() {
//     _commentsStream
//         .bindStream(Get.find<DatabaseController>().getComments(postId: postId));
//     super.onInit();
//   }
//
//   Future<void> addComment(ReplyModel comment) async {
//     try {
//       final db = Get.find<DatabaseController>();
//       await db.addComment(comment);
//       return;
//     } catch (e) {
//       displayError(e);
//       return;
//     }
//   }
// }
