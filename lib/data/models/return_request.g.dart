// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReturnRequestImpl _$$ReturnRequestImplFromJson(Map<String, dynamic> json) =>
    _$ReturnRequestImpl(
      id: stringToInt(json['id']),
      reason: json['reason'] as String?,
      status: json['status'] as String?,
      orderId: stringToInt(json['orderId']),
      createdAt: stringToDateTimeNullable(json['createdAt']),
    );

Map<String, dynamic> _$$ReturnRequestImplToJson(_$ReturnRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reason': instance.reason,
      'status': instance.status,
      'orderId': instance.orderId,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
