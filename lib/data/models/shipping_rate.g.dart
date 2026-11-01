// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping_rate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShippingRateImpl _$$ShippingRateImplFromJson(Map<String, dynamic> json) =>
    _$ShippingRateImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      cost: stringToDouble(json['cost']),
      rateType: json['rateType'] as String,
    );

Map<String, dynamic> _$$ShippingRateImplToJson(_$ShippingRateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cost': doubleToString(instance.cost),
      'rateType': instance.rateType,
    };
