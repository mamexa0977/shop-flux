import 'package:freezed_annotation/freezed_annotation.dart';
import 'order.dart';


part 'seller_order_group.freezed.dart';
part 'seller_order_group.g.dart';

@freezed
class SellerOrderGroup with _$SellerOrderGroup {
  const factory SellerOrderGroup({
    required Order order,
    required List<OrderItem> items, // only items belonging to this seller
  }) = _SellerOrderGroup;

  factory SellerOrderGroup.fromJson(Map<String, dynamic> json) => _$SellerOrderGroupFromJson(json);
}