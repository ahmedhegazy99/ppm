import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/controllers/userController.dart';
import 'package:pro_player_market/models/playerModel.dart';
import 'package:pro_player_market/models/requestModel.dart';
import 'package:pro_player_market/models/userModel.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';

import 'authController.dart';

class DatabaseController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  var posts = RxList<PlayerModel>();
  var newPosts = Rxn<QuerySnapshot>();
  var loading = false.obs;
  var uploading = false.obs;

  @override
  void onInit() {
    getPosts();
  }

  @override
  void onReady() {
    newPosts.bindStream(_firestore.collection('players').snapshots());
    ever(newPosts, (dynamic newVal) {
      if (newVal!.documents.length != posts.length) {
        getPosts(update: true);
      }
    });
  }

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('users').doc(uid).get();
      // return UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
      if (documentSnapshot.exists)
        return UserModel.fromJson(
            documentSnapshot.data()! as Map<String, dynamic>);
      else {
        print("User Not Found");
        throw Exception("User Not Found");
      }
    } catch (e) {
      Get.find<AuthController>().signOut();
      return Get.find<UserController>().user;
    }
  }

  Future<void> addPost(PlayerModel post, {File? image , File? video}) async {
    try {
      uploading.toggle();
      //print('add post     $image');
      if (image != null) {
        post.photo = await uploadPlayerImage(post, image);
      }
      if (video != null) {
        post.video = await uploadPlayerVideo(post, video);
      }
      await _firestore.collection('players').add(post.toJson())
       .then((doc) => doc.update({"id": doc.id}));
      uploading.toggle();
    } catch (e) {
      uploading.toggle();
      displayError(e);
      //return;
    }
  }

  Future<void> updatePost(PlayerModel post) async {
    try {
      await _firestore.collection('players').doc(post.id).update(post.toJson());
      //return;
    } catch (e) {
      displayError(e);
      //return;
    }
  }

  Future<void> deletePost(String playerId) async {
    try {
      bool? delete = await Get.defaultDialog<bool>(
          title: 'warning'.tr,
          content: Text('confirmPlayertDelete'.tr),
          actions: [
            RaisedButton(
              onPressed: () => Get.back(result: true),
              child: Text('delete'.tr),
              color: Colors.red,
            ),
            RaisedButton(
              onPressed: () => Get.back(result: false),
              child: Text('cancel'.tr),
            )
          ]);
      if (delete!) {
        _firestore.collection('players').doc(playerId).delete();
      }
      //return;
    } catch (e) {
      displayError(e);
      //return;
    }
  }

  Stream<List<PlayerModel>> getPosts({bool update = false}) {
    return _firestore
        .collection('players')
        .orderBy('joinDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PlayerModel.fromJson(doc.data()))
            .toList());
  }

/*
  Stream<List<PlayerModel>> ? getUserPosts(String userId) {
    try {
      return _firestore
          .collection('players')
          .where('userId', isEqualTo: userId)
          .orderBy('age', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => PlayerModel.fromJson(doc.data()))
          .toList());
    } on StateError catch(e) {
      displayError(e);
    }
  }
*/

  Future<List<PlayerModel>?> getUserPosts(String userId) async {
    try {
      QuerySnapshot postsDocs = await _firestore
          .collection('players')
          .where('userId', isEqualTo: userId)
          .get();

      List<PlayerModel> posts = [];
      postsDocs.docs.forEach((dynamic element) {
        posts.add(PlayerModel.fromJson(element.data()));
      });

      posts.sort((a, b) => b.joinDate!.compareTo(a.joinDate!));
      return posts;
    } catch (e) {
      displayError(e);
      /*Get.snackbar(
        "Error creating Account",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );*/
      //return null;
    }
  }

  Future<PlayerModel> getPlayer(String pid) async {
    try {
      DocumentSnapshot documentSnapshot =
      await _firestore.collection('players').doc(pid).get();
      if (documentSnapshot.exists)
        return PlayerModel.fromJson(
            documentSnapshot.data()! as Map<String, dynamic>);
      else {
        print("PLAYER Not Found");
        throw Exception("Player Not Found");
      }
    } catch (e) {
      displayError(e);
      return PlayerModel.fromJson({});
    }
  }

  /*Future<String> addComment(ReplyModel comment) async {
    try {
      String id;
      await _firestore.collection('comments').add(comment.toJson()).then((doc) {
        id = doc.documentID;
        doc.updateData({"id": id});
      });
      return id;
    } catch (e) {
      displayError(e);
      return null;
    }
  }

  Stream<List<ReplyModel>> getComments({@required postId}) {
    return _firestore
        .collection('comments')
        .where('postId', isEqualTo: postId)
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((doc) => ReplyModel.fromJson(doc.data))
            .toList());
  }
*/
  Future<String?> uploadPlayerImage(PlayerModel post, File image) async {
    try {
      String imageName = 'IMG_${post.name}_${post.joinDate}.jpg';
      Reference reference = _storage.ref().child('players/photo/$imageName');
      UploadTask uploadTask = reference.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();

      return imageUrl;
    } catch (e) {
      displayError(e);
      Get.snackbar(
        "Error uploading image",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      //return null;
    }
  }

  Future<String?> uploadPlayerVideo(PlayerModel post, File video) async {
    try {
      String imageName = 'VID_${post.name}_${post.joinDate}.mp4';
      Reference reference = _storage.ref().child('players/video/$imageName');
      UploadTask uploadTask = reference.putFile(video);
      TaskSnapshot snapshot = await uploadTask;
      String videoUrl = await snapshot.ref.getDownloadURL();

      return videoUrl;
    } catch (e) {
      displayError(e);
      Get.snackbar(
        "Error uploading video",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      //return null;
    }
  }

  Future<void> CreateBuyRequest(RequestModel request) async {
    try {
      uploading.toggle();
      
      await _firestore.collection('BuyRequests').add(request.toJson())
          .then((doc) => doc.update({"id": doc.id}));
      uploading.toggle();
    } catch (e) {
      uploading.toggle();
      displayError(e);
    }
  }

  Stream<List<RequestModel>> getRequests({bool update = false}) {
    return _firestore
        .collection('BuyRequests')
        //.orderBy('requestDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => RequestModel.fromJson(doc.data()))
        .toList());
  }
  
}
