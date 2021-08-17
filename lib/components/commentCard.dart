// import 'package:Minders/models/replyModel.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class CommentCard extends StatelessWidget {
//   final ReplyModel comment;
//   const CommentCard({Key key, this.comment}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(10),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(20.0),
//         ),
//       ),
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.only(
//               top: 5,
//             ),
//             child: ListTile(
//               leading: CircleAvatar(
//                 radius: 25,
//                 backgroundColor: Colors.grey[200],
//                 backgroundImage: NetworkImage(comment.userImage ??
//                     'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png'),
//               ),
//               title: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     comment.userName,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                   Text(
//                     DateFormat.yMEd().format(comment.date),
//                     style: TextStyle(
//                         fontWeight: FontWeight.normal,
//                         fontSize: 14,
//                         color: Colors.grey),
//                   ),
//                 ],
//               ),
//               subtitle: Text(
//                 '@${comment.userName}',
//                 style: TextStyle(
//                     fontWeight: FontWeight.normal,
//                     fontSize: 14,
//                     color: Colors.grey),
//               ),
//             ),
//           ),
//           // //post text
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 10),
//             margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
//             child: Row(
//               children: [
//                 Text(
//                   comment.content,
//                   style: TextStyle(
//                     fontWeight: FontWeight.normal,
//                     fontSize: 18,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
