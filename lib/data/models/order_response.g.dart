// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderResponseImpl _$$OrderResponseImplFromJson(Map<String, dynamic> json) =>
    _$OrderResponseImpl(
      order: Order.fromJson(json['order'] as Map<String, dynamic>),
      payment:
          json['payment'] == null
              ? null
              : PaymentInit.fromJson(json['payment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OrderResponseImplToJson(_$OrderResponseImpl instance) =>
    <String, dynamic>{'order': instance.order, 'payment': instance.payment};
