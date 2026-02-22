// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BannerImpl _$$BannerImplFromJson(Map<String, dynamic> json) => _$BannerImpl(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String?,
  description: json['description'] as String?,
  imageUrl: json['imageUrl'] as String,
  link: json['link'] as String?,
  buttonText: json['buttonText'] as String?,
  position: (json['position'] as num?)?.toInt(),
  isActive: json['isActive'] as bool?,
  startDate:
      json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
  endDate:
      json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
);

Map<String, dynamic> _$$BannerImplToJson(_$BannerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'link': instance.link,
      'buttonText': instance.buttonText,
      'position': instance.position,
      'isActive': instance.isActive,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
    };
