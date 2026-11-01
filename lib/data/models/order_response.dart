import 'package:freezed_annotation/freezed_annotation.dart';
import 'order.dart';
import 'payment_init.dart';

part 'order_response.freezed.dart';
part 'order_response.g.dart';

@freezed
class OrderResponse with _$OrderResponse {
  const factory OrderResponse({
    required Order order,
    PaymentInit? payment, // present only for Chapa
  }) = _OrderResponse;

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);
}