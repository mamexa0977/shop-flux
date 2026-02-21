// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: stringToInt(json['id']),
      name: json['name'] as String,
      description: json['description'] as String?,
      price: stringToDouble(json['price']),
      discountPrice: stringToDoubleNullable(json['discountPrice']),
      sku: json['sku'] as String?,
      stock: stringToIntNullable(json['stock']),
      brand: json['brand'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
      dimensions: json['dimensions'] as String?,
      isActive: json['isActive'] as bool?,
      isFeatured: json['isFeatured'] as bool?,
      categoryId: stringToIntNullable(json['categoryId']),
      seller:
          json['seller'] == null
              ? null
              : User.fromJson(json['seller'] as Map<String, dynamic>),
      images:
          (json['ProductImages'] as List<dynamic>?)
              ?.map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
              .toList(),
      variants:
          (json['ProductVariants'] as List<dynamic>?)
              ?.map((e) => ProductVariant.fromJson(e as Map<String, dynamic>))
              .toList(),
      reviews:
          (json['Reviews'] as List<dynamic>?)
              ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'discountPrice': instance.discountPrice,
      'sku': instance.sku,
      'stock': instance.stock,
      'brand': instance.brand,
      'weight': instance.weight,
      'dimensions': instance.dimensions,
      'isActive': instance.isActive,
      'isFeatured': instance.isFeatured,
      'categoryId': instance.categoryId,
      'seller': instance.seller,
      'ProductImages': instance.images,
      'ProductVariants': instance.variants,
      'Reviews': instance.reviews,
    };
