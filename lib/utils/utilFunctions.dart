// Help to store datetime in firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

DateTime? dateTimeFromTimestamp(Timestamp? timestamp) =>
    timestamp == null ? null : DateTime.parse(timestamp.toDate().toString());
Timestamp? dateTimeToTimestamp(DateTime? dateTime) =>
    dateTime == null ? null : Timestamp.fromDate(dateTime);

 calculateAge(DateTime d){
  Duration days = DateTime.now().difference(d);
  var age = days.inDays;
  return age/365;
}

void displayError(dynamic e) {
  Get.snackbar(
    "error".tr,
    'errorOccured'.tr,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
  );
}
