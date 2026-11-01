// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_order_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SellerOrderGroupImpl _$$SellerOrderGroupImplFromJson(
  Map<String, dynamic> json,
) => _$SellerOrderGroupImpl(
  order: Order.fromJson(json['order'] as Map<String, dynamic>),
  items:
      (json['items'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$$SellerOrderGroupImplToJson(
  _$SellerOrderGroupImpl instance,
) => <String, dynamic>{'order': instance.order, 'items': instance.items};
