// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderRequestImpl _$$OrderRequestImplFromJson(Map<String, dynamic> json) =>
    _$OrderRequestImpl(
      addressId: (json['addressId'] as num).toInt(),
      shippingMethod: json['shippingMethod'] as String,
      paymentMethod: json['paymentMethod'] as String,
    );

Map<String, dynamic> _$$OrderRequestImplToJson(_$OrderRequestImpl instance) =>
    <String, dynamic>{
      'addressId': instance.addressId,
      'shippingMethod': instance.shippingMethod,
      'paymentMethod': instance.paymentMethod,
    };
