// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cityModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityModel _$CityModelFromJson(Map<String, dynamic> json) {
  return CityModel(
    id: json['id'] as String?,
    cityName: json['cityName'] as String?,
  );
}

Map<String, dynamic> _$CityModelToJson(CityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.cityName,
    };
