import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/utils/json_converters.dart';
import 'product.dart';
import 'product_variant.dart'; // for OrderItem's product

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class Order with _$Order {
  const factory Order({
    @JsonKey(fromJson: stringToInt) required int id,
    required String orderNumber,
    required String status,
    @JsonKey(fromJson: stringToDouble) required double totalAmount,
    required String shippingAddress,
    String? shippingMethod,
    required String paymentMethod,
    required String paymentStatus,
    @JsonKey(name: 'OrderItems') List<OrderItem>? items,
    DateTime? createdAt,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

@freezed
class OrderItem with _$OrderItem {
  const factory OrderItem({
    @JsonKey(fromJson: stringToInt) required int id,
    @JsonKey(fromJson: stringToInt) required int quantity,
    @JsonKey(fromJson: stringToDouble) required double price,
    Product? product,
    @JsonKey(name: 'ProductVariant') ProductVariant? variant,
    String? itemStatus,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
}