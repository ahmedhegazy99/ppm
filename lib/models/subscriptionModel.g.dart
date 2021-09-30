// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscriptionModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionModel _$SubscriptionModelFromJson(Map<String, dynamic> json) {
  return SubscriptionModel(
    id: json['id'] as String?,
    userId: json['userId'] as String?,
    transactionId: json['transactionId'] as String?,
    subscriptionDate: dateTimeFromTimestamp(json['subscriptionDate'] as Timestamp?),
    endDate: dateTimeFromTimestamp(json['endDate'] as Timestamp?),
  );
}

Map<String, dynamic> _$SubscriptionModelToJson(SubscriptionModel instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'transactionId': instance.transactionId,
  'subscriptionDate': dateTimeToTimestamp(instance.subscriptionDate),
  'endDate': dateTimeToTimestamp(instance.endDate),
};
