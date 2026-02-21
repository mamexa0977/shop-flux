// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewImpl _$$ReviewImplFromJson(Map<String, dynamic> json) => _$ReviewImpl(
  id: stringToInt(json['id']),
  rating: stringToInt(json['rating']),
  comment: json['comment'] as String?,
  user:
      json['User'] == null
          ? null
          : User.fromJson(json['User'] as Map<String, dynamic>),
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rating': instance.rating,
      'comment': instance.comment,
      'User': instance.user,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
