import 'package:freezed_annotation/freezed_annotation.dart';

part 'wishlist.freezed.dart';
part 'wishlist.g.dart';

@freezed
class WishlistItem with _$WishlistItem {
  const factory WishlistItem({
    required int id,
    required int userId,
    required int productId,
    WishlistProduct? Product, // Capital 'P' to match your Sequelize backend include
  }) = _WishlistItem;

  factory WishlistItem.fromJson(Map<String, dynamic> json) => _$WishlistItemFromJson(json);
}

@freezed
class WishlistProduct with _$WishlistProduct {
  const factory WishlistProduct({
    required int id,
    required String name,
    required double price,
    double? discountPrice,
    List<ProductImage>? ProductImages,
  }) = _WishlistProduct;

  factory WishlistProduct.fromJson(Map<String, dynamic> json) => _$WishlistProductFromJson(json);
}

@freezed
class ProductImage with _$ProductImage {
  const factory ProductImage({
    required int id,
    required String imageUrl,
    required bool isPrimary,
  }) = _ProductImage;

  factory ProductImage.fromJson(Map<String, dynamic> json) => _$ProductImageFromJson(json);
}