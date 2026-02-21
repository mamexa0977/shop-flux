// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_variant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductVariantImpl _$$ProductVariantImplFromJson(Map<String, dynamic> json) =>
    _$ProductVariantImpl(
      id: stringToInt(json['id']),
      attributes: json['attributes'] as Map<String, dynamic>,
      sku: json['sku'] as String?,
      price: stringToDoubleNullable(json['price']),
      stock: stringToIntNullable(json['stock']),
    );

Map<String, dynamic> _$$ProductVariantImplToJson(
  _$ProductVariantImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'attributes': instance.attributes,
  'sku': instance.sku,
  'price': instance.price,
  'stock': instance.stock,
};
