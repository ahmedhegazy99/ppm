// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playerModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerModel _$PlayerModelFromJson(Map<String, dynamic> json) {
  return PlayerModel(
    contentUrl: json['contentUrl'] as String?,
    date: dateTimeFromTimestamp(json['date'] as Timestamp?),
    text: json['text'] as String?,
    type: _$enumDecodeNullable(_$PostTypeEnumEnumMap, json['type']),
    userId: json['userId'] as String?,
    userImage: json['userImage'] as String?,
    userName: json['userName'] as String?,
    id: json['id'] as String?,
    upvotes:
        (json['upvotes'] as List<dynamic>?)?.map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$PlayerModelToJson(PlayerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userName': instance.userName,
      'userImage': instance.userImage,
      'date': dateTimeToTimestamp(instance.date),
      'text': instance.text,
      'type': _$PostTypeEnumEnumMap[instance.type],
      'contentUrl': instance.contentUrl,
      'upvotes': instance.upvotes,
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

const _$PostTypeEnumEnumMap = {
  PostTypeEnum.photo: 'photo',
  PostTypeEnum.text: 'text',
};
