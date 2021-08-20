// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['id'] as String?,
    userType: _$enumDecodeNullable(_$UserTypeEnumEnumMap, json['userType']),
    name: json['name'] as String?,
    mobile: json['mobile'] as String?,
    imageUrl: json['imageUrl'] as String?,
    email: json['email'] as String?,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'userType': _$UserTypeEnumEnumMap[instance.userType],
      'name': instance.name,
      'email': instance.email,
      'mobile': instance.mobile,
      'imageUrl': instance.imageUrl,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$UserTypeEnumEnumMap = {
  UserTypeEnum.admin: 'admin',
  UserTypeEnum.club: 'club',
  UserTypeEnum.userPlayer: 'userPlayer',
};
