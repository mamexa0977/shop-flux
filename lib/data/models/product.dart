import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';
import 'product_variant.dart';
import 'product_image.dart';
import 'review.dart';
import '../../core/utils/json_converters.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    @JsonKey(fromJson: stringToInt) required int id,
    required String name,
    String? description,
    @JsonKey(fromJson: stringToDouble) required double price,
    @JsonKey(fromJson: stringToDoubleNullable) double? discountPrice,
    String? sku,
    @JsonKey(fromJson: stringToIntNullable) int? stock,
    String? brand,
    double? weight,
    String? dimensions,
    bool? isActive,
    bool? isFeatured,
    @JsonKey(fromJson: stringToIntNullable) int? categoryId,
    @JsonKey(name: 'seller') User? seller,
    @JsonKey(name: 'ProductImages') List<ProductImage>? images,
    @JsonKey(name: 'ProductVariants') List<ProductVariant>? variants,
    @JsonKey(name: 'Reviews') List<Review>? reviews,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}