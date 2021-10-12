// Help to store datetime in firestore
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

DateTime? dateTimeFromTimestamp(Timestamp? timestamp) =>
    timestamp == null ? null : DateTime.parse(timestamp.toDate().toString());
Timestamp? dateTimeToTimestamp(DateTime? dateTime) =>
    dateTime == null ? null : Timestamp.fromDate(dateTime);

calculateAge(DateTime d){
  Duration days = DateTime.now().difference(d);
  var ageDays = days.inDays;
  int age = (ageDays~/365).toInt();
  return age;
}

Future selectDate(BuildContext context) async {
  var selectedDate = DateTime(DateTime.now().year - 15);
  final DateTime? selected = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(DateTime.now().year - 40),
    lastDate: DateTime(DateTime.now().year - 15),
  );
  if (selected != null && selected != selectedDate) {
    selectedDate = selected;
    return selected;
  }
}

void displayError(dynamic e, {dynamic ee}) {
  Get.snackbar(
    e,
    ee??'error'.tr,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
  );
}

Future<void> waitUntilDone(var toCheck) async {

  final completer = Completer();
  if (toCheck == null) {
    await 200.milliseconds.delay();
    return waitUntilDone(toCheck);
  } else {
    print(toCheck);
    completer.complete();
  }
  return completer.future;
}
