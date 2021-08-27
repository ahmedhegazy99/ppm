// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playerModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerModel _$PlayerModelFromJson(Map<String, dynamic> json) {
  return PlayerModel(
    id: json['id'] as String?,
    userId: json['userId'] as String?,
    joinDate: dateTimeFromTimestamp(json['joinDate'] as Timestamp?),
    name: json['name'] as String?,
    photo: json['photo'] as String?,
    video: json['video'] as String?,
    city: json['city'] as String?,
    birthDate: json['birthDate'] == null
        ? null
        : DateTime.parse(json['birthDate'] as String),
    bio: json['bio'] as String?,
    upvotes:
        (json['upvotes'] as List<dynamic>?)?.map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$PlayerModelToJson(PlayerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'joinDate': dateTimeToTimestamp(instance.joinDate),
      'name': instance.name,
      'photo': instance.photo,
      'video': instance.video,
      'city': instance.city,
      'birthDate': instance.birthDate?.toIso8601String(),
      'bio': instance.bio,
      'upvotes': instance.upvotes,
    };
