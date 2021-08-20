// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['id'] as String,
    userType: _$enumDecodeNullable(_$UserTypeEnumEnumMap, json['type']),
    name: json['name'] as String,
    mobile: json['mobile'] as String,
    imageUrl: json['imageUrl'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'type': _$UserTypeEnumEnumMap[instance.userType],
  'name': instance.name,
  'email': instance.email,
  'mobile': instance.mobile,
  'imageUrl': instance.imageUrl,
};

T _$enumDecode<T>(
    Map<T, dynamic> enumValues,
    dynamic source, {
      T ? unknownValue,
    }) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source)
//      .singleWhere((e) => e.value == source, orElse: () => null!)
      .key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue!;
}

T _$enumDecodeNullable<T>(
    Map<T, dynamic> enumValues,
    dynamic source, {
      T? unknownValue,
    }) {
  if (source == null) {
    return null!;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$UserTypeEnumEnumMap = {
  UserTypeEnum.admin: 'admin',
  UserTypeEnum.club: 'club',
  UserTypeEnum.userPlayer: 'userPlayer',
};
/*
Map<Rx<UserTypeEnum>, dynamic> UserTypeEnumEnumMap = {
  UserTypeEnum.admin: 'admin',
  UserTypeEnum.club: 'club',
  UserTypeEnum.userPlayer: 'userPlayer',
};*/

