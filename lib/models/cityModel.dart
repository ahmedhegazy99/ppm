import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';

part 'cityModel.g.dart';

@JsonSerializable(explicitToJson: true)
class CityModel {
  String ? id;
  String ? cityName;

  CityModel({
    this.id,
    this.cityName,
  });

  CityModel copy() => CityModel.fromJson(this.toJson());
  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);
  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}

//enum PostTypeEnum { photo, text }
