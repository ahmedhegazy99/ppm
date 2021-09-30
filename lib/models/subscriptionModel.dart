import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';

part 'subscriptionModel.g.dart';

@JsonSerializable(explicitToJson: true)
class SubscriptionModel {
  String ? id;
  String ? userId;
  String ? transactionId;
  @JsonKey(fromJson: dateTimeFromTimestamp, toJson: dateTimeToTimestamp)
  DateTime ? subscriptionDate;
  DateTime ? endDate;

  SubscriptionModel({
    this.id,
    this.userId,
    this.transactionId,
    this.subscriptionDate,
    this.endDate
  });

  SubscriptionModel copy() => SubscriptionModel.fromJson(this.toJson());
  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionModelToJson(this);
}

