import 'package:freezed_annotation/freezed_annotation.dart';
import 'wishlist.dart'; // Reusing ProductImage from wishlist model for DRY code

part 'cart.freezed.dart';
part 'cart.g.dart';

@freezed
class CartData with _$CartData {
  const factory CartData({
    required int id,
    @Default([]) List<CartItem> items,
    required double subtotal,
  }) = _CartData;

  factory CartData.fromJson(Map<String, dynamic> json) => _$CartDataFromJson(json);
}

@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required int id,
    required int cartId,
    required int productId,
    int? variantId,
    required int quantity,
    CartProduct? Product, // Backend uses capitalized 'Product'
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);
}

@freezed
class CartProduct with _$CartProduct {
  const factory CartProduct({
    required int id,
    required String name,
    required double price,
    List<ProductImage>? ProductImages,
  }) = _CartProduct;

  factory CartProduct.fromJson(Map<String, dynamic> json) => _$CartProductFromJson(json);
}