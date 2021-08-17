import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';

part 'playerModel.g.dart';

@JsonSerializable(explicitToJson: true)
class PlayerModel {
  String ? id;
  String ? userId;
  String ? userName;
  String ? userImage;
  @JsonKey(fromJson: dateTimeFromTimestamp, toJson: dateTimeToTimestamp)
  DateTime ? date;
  String ? text;
  PostTypeEnum ? type;
  String ? contentUrl;
  List<String> ? upvotes;

  PlayerModel({
    this.contentUrl,
    this.date,
    this.text,
    this.type,
    this.userId,
    this.userImage,
    this.userName,
    this.id,
    this.upvotes,
  });

  PlayerModel copy() => PlayerModel.fromJson(this.toJson());
  factory PlayerModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerModelFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerModelToJson(this);
}

enum PostTypeEnum { photo, text }
