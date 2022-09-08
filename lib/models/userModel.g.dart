// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['id'] as String?,
    userType: _$enumDecodeNullable(_$UserTypeEnumEnumMap, json['userType']),
    joinDate: dateTimeFromTimestamp(json['joinDate'] as Timestamp?),
    name: json['name'] as String?,
    mobile: json['mobile'] as String?,
    imageUrl: json['imageUrl'] as String?,
    email: json['email'] as String?,
    address: json['address'] as String?,
    city: json['city'] as String?,
    birthDate: json['birthDate'] == null
        ? null
        : DateTime.parse(json['birthDate'] as String),
    requests:
    (json['requests'] as List<dynamic>?)?.map((e) => e as String).toList(),
    subscriptionsHistory: (json['subscriptionsHistory'] as List<dynamic>?)?.map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'userType': _$UserTypeEnumEnumMap[instance.userType],
  'joinDate': dateTimeToTimestamp(instance.joinDate),
  'name': instance.name,
  'email': instance.email,
  'mobile': instance.mobile,
  'imageUrl': instance.imageUrl,
  'address': instance.address,
  'city': instance.city,
  'birthDate': instance.birthDate?.toIso8601String(),
  'requests': instance.requests,
  'subscriptionsHistory': instance.subscriptionsHistory,
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
