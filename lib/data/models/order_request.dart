import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_request.freezed.dart';
part 'order_request.g.dart';

@freezed
class OrderRequest with _$OrderRequest {
  const factory OrderRequest({
    required int addressId,
    required String shippingMethod,
    required String paymentMethod,
  }) = _OrderRequest;

  factory OrderRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestFromJson(json);
}