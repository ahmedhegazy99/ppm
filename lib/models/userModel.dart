import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';
part 'userModel.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  String? id;
  UserTypeEnum? userType;
  @JsonKey(fromJson: dateTimeFromTimestamp, toJson: dateTimeToTimestamp)
  DateTime ? joinDate;
  String? name;
  String? email;
  String? mobile;
  String? imageUrl;
  String? address;
  String ? city;
  DateTime ? birthDate;
  List<String> ? requests;
  List<String> ? subscriptionsHistory;

  UserModel({
    this.id,
    this.userType,
    this.joinDate,
    this.name,
    this.mobile,
    this.imageUrl,
    this.email,
    this.address,
    this.city,
    this.birthDate,
    this.requests,
    this.subscriptionsHistory,
  });

  UserModel copy() => UserModel.fromJson(this.toJson());
  factory UserModel.fromJson(Map<String, dynamic>? json) =>
      _$UserModelFromJson(json!);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

enum UserTypeEnum { admin, club, userPlayer }
