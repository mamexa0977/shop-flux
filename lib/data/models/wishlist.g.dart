// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WishlistItemImpl _$$WishlistItemImplFromJson(Map<String, dynamic> json) =>
    _$WishlistItemImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      productId: (json['productId'] as num).toInt(),
      Product:
          json['Product'] == null
              ? null
              : WishlistProduct.fromJson(
                json['Product'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$$WishlistItemImplToJson(_$WishlistItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'productId': instance.productId,
      'Product': instance.Product,
    };

_$WishlistProductImpl _$$WishlistProductImplFromJson(
  Map<String, dynamic> json,
) => _$WishlistProductImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  price: (json['price'] as num).toDouble(),
  discountPrice: (json['discountPrice'] as num?)?.toDouble(),
  ProductImages:
      (json['ProductImages'] as List<dynamic>?)
          ?.map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$$WishlistProductImplToJson(
  _$WishlistProductImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'price': instance.price,
  'discountPrice': instance.discountPrice,
  'ProductImages': instance.ProductImages,
};

_$ProductImageImpl _$$ProductImageImplFromJson(Map<String, dynamic> json) =>
    _$ProductImageImpl(
      id: (json['id'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
      isPrimary: json['isPrimary'] as bool,
    );

Map<String, dynamic> _$$ProductImageImplToJson(_$ProductImageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'isPrimary': instance.isPrimary,
    };
