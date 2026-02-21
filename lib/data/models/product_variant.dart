import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/utils/json_converters.dart';

part 'product_variant.freezed.dart';
part 'product_variant.g.dart';

@freezed
class ProductVariant with _$ProductVariant {
  const factory ProductVariant({
    @JsonKey(fromJson: stringToInt) required int id,
    required Map<String, dynamic> attributes,
    String? sku,
    @JsonKey(fromJson: stringToDoubleNullable) double? price,
    @JsonKey(fromJson: stringToIntNullable) int? stock,
  }) = _ProductVariant;

  factory ProductVariant.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantFromJson(json);
}