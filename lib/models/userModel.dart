import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
part 'userModel.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  String? id;
  UserTypeEnum? userType;
  //Rx<UserTypeEnum> ? userType;
  String? name;
  String? email;
  String? mobile;
  String? imageUrl;

  UserModel(
      {this.id,
      this.userType,
      this.name,
      this.mobile,
      this.imageUrl,
      this.email});

  UserModel copy() => UserModel.fromJson(this.toJson());
  factory UserModel.fromJson(Map<String, dynamic>? json) =>
      _$UserModelFromJson(json!);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

enum UserTypeEnum { admin, club, userPlayer }
