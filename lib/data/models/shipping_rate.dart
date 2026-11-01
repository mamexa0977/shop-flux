import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/utils/json_converters.dart'; // adjust path as needed

part 'shipping_rate.freezed.dart';
part 'shipping_rate.g.dart';

@freezed
class ShippingRate with _$ShippingRate {
  const factory ShippingRate({
    required int id,
    required String name,
    @JsonKey(fromJson: stringToDouble, toJson: doubleToString) required double cost,
    required String rateType,
  }) = _ShippingRate;

  factory ShippingRate.fromJson(Map<String, dynamic> json) =>
      _$ShippingRateFromJson(json);
}