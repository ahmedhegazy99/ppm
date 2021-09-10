// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requestModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestModel _$RequestModelFromJson(Map<String, dynamic> json) {
  return RequestModel(
    id: json['id'] as String?,
    userId: json['userId'] as String?,
    //playerId: json['playerId'] as String?,
    requestDate: dateTimeFromTimestamp(json['requestDate'] as Timestamp?),
    //title: json['title'] as String?,
    type: _$enumDecodeNullable(_$RequestTypeEnumEnumMap, json['type']),
    status: json['status'] as bool?,
    info: json['info'],
  );
}

Map<String, dynamic> _$RequestModelToJson(RequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      //'playerId': instance.playerId,
      'requestDate': dateTimeToTimestamp(instance.requestDate),
      //'title': instance.title,
      'type': _$RequestTypeEnumEnumMap[instance.type],
      'status': instance.status,
      'info': instance.info,
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

const _$RequestTypeEnumEnumMap = {
  RequestTypeEnum.deal: 'deal',
  RequestTypeEnum.post: 'post',
};
