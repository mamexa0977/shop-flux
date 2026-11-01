// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderImpl _$$OrderImplFromJson(Map<String, dynamic> json) => _$OrderImpl(
  id: stringToInt(json['id']),
  orderNumber: json['orderNumber'] as String,
  status: json['status'] as String,
  totalAmount: stringToDouble(json['totalAmount']),
  shippingAddress: json['shippingAddress'] as String,
  shippingMethod: json['shippingMethod'] as String?,
  paymentMethod: json['paymentMethod'] as String,
  paymentStatus: json['paymentStatus'] as String,
  items:
      (json['OrderItems'] as List<dynamic>?)
          ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$OrderImplToJson(_$OrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderNumber': instance.orderNumber,
      'status': instance.status,
      'totalAmount': instance.totalAmount,
      'shippingAddress': instance.shippingAddress,
      'shippingMethod': instance.shippingMethod,
      'paymentMethod': instance.paymentMethod,
      'paymentStatus': instance.paymentStatus,
      'OrderItems': instance.items,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$OrderItemImpl _$$OrderItemImplFromJson(Map<String, dynamic> json) =>
    _$OrderItemImpl(
      id: stringToInt(json['id']),
      quantity: stringToInt(json['quantity']),
      price: stringToDouble(json['price']),
      product:
          json['product'] == null
              ? null
              : Product.fromJson(json['product'] as Map<String, dynamic>),
      variant:
          json['ProductVariant'] == null
              ? null
              : ProductVariant.fromJson(
                json['ProductVariant'] as Map<String, dynamic>,
              ),
      itemStatus: json['itemStatus'] as String?,
    );

Map<String, dynamic> _$$OrderItemImplToJson(_$OrderItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'price': instance.price,
      'product': instance.product,
      'ProductVariant': instance.variant,
      'itemStatus': instance.itemStatus,
    };
