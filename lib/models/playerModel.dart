import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';

part 'playerModel.g.dart';

@JsonSerializable(explicitToJson: true)
class PlayerModel {
  String ? id;
  String ? userId;
  @JsonKey(fromJson: dateTimeFromTimestamp, toJson: dateTimeToTimestamp)
  DateTime ? joinDate;
  String ? name;
  String ? photo;
  String ? video;
  String ? city;
  DateTime ? birthDate;
  //String ? mobile;
  //String ? email;
  String ? bio;
  List<String> ? upvotes;

  PlayerModel({
    this.id,
    this.userId,
    this.joinDate,
    this.name,
    this.photo,
    this.video,
    this.city,
    this.birthDate,
    //this.mobile,
    //this.email,
    this.bio,
    this.upvotes,
  });

  PlayerModel copy() => PlayerModel.fromJson(this.toJson());
  factory PlayerModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerModelFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerModelToJson(this);
}

//enum PostTypeEnum { photo, text }
