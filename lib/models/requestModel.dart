import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';

part 'requestModel.g.dart';

@JsonSerializable(explicitToJson: true)
class RequestModel {
  String ? id;
  String ? userId;
  String ? playerId;
  @JsonKey(fromJson: dateTimeFromTimestamp, toJson: dateTimeToTimestamp)
  DateTime ? requestDate;
  String ? title;
  RequestTypeEnum ?type;

  RequestModel({
    this.id,
    this.userId,
    this.playerId,
    this.requestDate,
    this.title,
    this.type
  });

  RequestModel copy() => RequestModel.fromJson(this.toJson());
  factory RequestModel.fromJson(Map<String, dynamic> json) =>
      _$RequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$RequestModelToJson(this);

}

enum RequestTypeEnum { buy, account }
