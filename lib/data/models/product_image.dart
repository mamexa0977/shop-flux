import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/utils/json_converters.dart';

part 'product_image.freezed.dart';
part 'product_image.g.dart';

@freezed
class ProductImage with _$ProductImage {
  const factory ProductImage({
    @JsonKey(fromJson: stringToInt) required int id,
    String? imageUrl,
    @JsonKey(name: 'isPrimary') bool? isPrimary,
  }) = _ProductImage;

  factory ProductImage.fromJson(Map<String, dynamic> json) =>
      _$ProductImageFromJson(json);
}