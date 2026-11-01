// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
mixin _$Order {
  @JsonKey(fromJson: stringToInt)
  int get id => throw _privateConstructorUsedError;
  String get orderNumber => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(fromJson: stringToDouble)
  double get totalAmount => throw _privateConstructorUsedError;
  String get shippingAddress => throw _privateConstructorUsedError;
  String? get shippingMethod => throw _privateConstructorUsedError;
  String get paymentMethod => throw _privateConstructorUsedError;
  String get paymentStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'OrderItems')
  List<OrderItem>? get items => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Order to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
  @useResult
  $Res call({
    @JsonKey(fromJson: stringToInt) int id,
    String orderNumber,
    String status,
    @JsonKey(fromJson: stringToDouble) double totalAmount,
    String shippingAddress,
    String? shippingMethod,
    String paymentMethod,
    String paymentStatus,
    @JsonKey(name: 'OrderItems') List<OrderItem>? items,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderNumber = null,
    Object? status = null,
    Object? totalAmount = null,
    Object? shippingAddress = null,
    Object? shippingMethod = freezed,
    Object? paymentMethod = null,
    Object? paymentStatus = null,
    Object? items = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            orderNumber:
                null == orderNumber
                    ? _value.orderNumber
                    : orderNumber // ignore: cast_nullable_to_non_nullable
                        as String,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            totalAmount:
                null == totalAmount
                    ? _value.totalAmount
                    : totalAmount // ignore: cast_nullable_to_non_nullable
                        as double,
            shippingAddress:
                null == shippingAddress
                    ? _value.shippingAddress
                    : shippingAddress // ignore: cast_nullable_to_non_nullable
                        as String,
            shippingMethod:
                freezed == shippingMethod
                    ? _value.shippingMethod
                    : shippingMethod // ignore: cast_nullable_to_non_nullable
                        as String?,
            paymentMethod:
                null == paymentMethod
                    ? _value.paymentMethod
                    : paymentMethod // ignore: cast_nullable_to_non_nullable
                        as String,
            paymentStatus:
                null == paymentStatus
                    ? _value.paymentStatus
                    : paymentStatus // ignore: cast_nullable_to_non_nullable
                        as String,
            items:
                freezed == items
                    ? _value.items
                    : items // ignore: cast_nullable_to_non_nullable
                        as List<OrderItem>?,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderImplCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$OrderImplCopyWith(
    _$OrderImpl value,
    $Res Function(_$OrderImpl) then,
  ) = __$$OrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(fromJson: stringToInt) int id,
    String orderNumber,
    String status,
    @JsonKey(fromJson: stringToDouble) double totalAmount,
    String shippingAddress,
    String? shippingMethod,
    String paymentMethod,
    String paymentStatus,
    @JsonKey(name: 'OrderItems') List<OrderItem>? items,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$OrderImplCopyWithImpl<$Res>
    extends _$OrderCopyWithImpl<$Res, _$OrderImpl>
    implements _$$OrderImplCopyWith<$Res> {
  __$$OrderImplCopyWithImpl(
    _$OrderImpl _value,
    $Res Function(_$OrderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderNumber = null,
    Object? status = null,
    Object? totalAmount = null,
    Object? shippingAddress = null,
    Object? shippingMethod = freezed,
    Object? paymentMethod = null,
    Object? paymentStatus = null,
    Object? items = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$OrderImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        orderNumber:
            null == orderNumber
                ? _value.orderNumber
                : orderNumber // ignore: cast_nullable_to_non_nullable
                    as String,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        totalAmount:
            null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                    as double,
        shippingAddress:
            null == shippingAddress
                ? _value.shippingAddress
                : shippingAddress // ignore: cast_nullable_to_non_nullable
                    as String,
        shippingMethod:
            freezed == shippingMethod
                ? _value.shippingMethod
                : shippingMethod // ignore: cast_nullable_to_non_nullable
                    as String?,
        paymentMethod:
            null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                    as String,
        paymentStatus:
            null == paymentStatus
                ? _value.paymentStatus
                : paymentStatus // ignore: cast_nullable_to_non_nullable
                    as String,
        items:
            freezed == items
                ? _value._items
                : items // ignore: cast_nullable_to_non_nullable
                    as List<OrderItem>?,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderImpl implements _Order {
  const _$OrderImpl({
    @JsonKey(fromJson: stringToInt) required this.id,
    required this.orderNumber,
    required this.status,
    @JsonKey(fromJson: stringToDouble) required this.totalAmount,
    required this.shippingAddress,
    this.shippingMethod,
    required this.paymentMethod,
    required this.paymentStatus,
    @JsonKey(name: 'OrderItems') final List<OrderItem>? items,
    this.createdAt,
  }) : _items = items;

  factory _$OrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderImplFromJson(json);

  @override
  @JsonKey(fromJson: stringToInt)
  final int id;
  @override
  final String orderNumber;
  @override
  final String status;
  @override
  @JsonKey(fromJson: stringToDouble)
  final double totalAmount;
  @override
  final String shippingAddress;
  @override
  final String? shippingMethod;
  @override
  final String paymentMethod;
  @override
  final String paymentStatus;
  final List<OrderItem>? _items;
  @override
  @JsonKey(name: 'OrderItems')
  List<OrderItem>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Order(id: $id, orderNumber: $orderNumber, status: $status, totalAmount: $totalAmount, shippingAddress: $shippingAddress, shippingMethod: $shippingMethod, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, items: $items, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.shippingAddress, shippingAddress) ||
                other.shippingAddress == shippingAddress) &&
            (identical(other.shippingMethod, shippingMethod) ||
                other.shippingMethod == shippingMethod) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    orderNumber,
    status,
    totalAmount,
    shippingAddress,
    shippingMethod,
    paymentMethod,
    paymentStatus,
    const DeepCollectionEquality().hash(_items),
    createdAt,
  );

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      __$$OrderImplCopyWithImpl<_$OrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderImplToJson(this);
  }
}

abstract class _Order implements Order {
  const factory _Order({
    @JsonKey(fromJson: stringToInt) required final int id,
    required final String orderNumber,
    required final String status,
    @JsonKey(fromJson: stringToDouble) required final double totalAmount,
    required final String shippingAddress,
    final String? shippingMethod,
    required final String paymentMethod,
    required final String paymentStatus,
    @JsonKey(name: 'OrderItems') final List<OrderItem>? items,
    final DateTime? createdAt,
  }) = _$OrderImpl;

  factory _Order.fromJson(Map<String, dynamic> json) = _$OrderImpl.fromJson;

  @override
  @JsonKey(fromJson: stringToInt)
  int get id;
  @override
  String get orderNumber;
  @override
  String get status;
  @override
  @JsonKey(fromJson: stringToDouble)
  double get totalAmount;
  @override
  String get shippingAddress;
  @override
  String? get shippingMethod;
  @override
  String get paymentMethod;
  @override
  String get paymentStatus;
  @override
  @JsonKey(name: 'OrderItems')
  List<OrderItem>? get items;
  @override
  DateTime? get createdAt;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) {
  return _OrderItem.fromJson(json);
}

/// @nodoc
mixin _$OrderItem {
  @JsonKey(fromJson: stringToInt)
  int get id => throw _privateConstructorUsedError;
  @JsonKey(fromJson: stringToInt)
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(fromJson: stringToDouble)
  double get price => throw _privateConstructorUsedError;
  Product? get product => throw _privateConstructorUsedError;
  @JsonKey(name: 'ProductVariant')
  ProductVariant? get variant => throw _privateConstructorUsedError;
  String? get itemStatus => throw _privateConstructorUsedError;

  /// Serializes this OrderItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderItemCopyWith<OrderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderItemCopyWith<$Res> {
  factory $OrderItemCopyWith(OrderItem value, $Res Function(OrderItem) then) =
      _$OrderItemCopyWithImpl<$Res, OrderItem>;
  @useResult
  $Res call({
    @JsonKey(fromJson: stringToInt) int id,
    @JsonKey(fromJson: stringToInt) int quantity,
    @JsonKey(fromJson: stringToDouble) double price,
    Product? product,
    @JsonKey(name: 'ProductVariant') ProductVariant? variant,
    String? itemStatus,
  });

  $ProductCopyWith<$Res>? get product;
  $ProductVariantCopyWith<$Res>? get variant;
}

/// @nodoc
class _$OrderItemCopyWithImpl<$Res, $Val extends OrderItem>
    implements $OrderItemCopyWith<$Res> {
  _$OrderItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? quantity = null,
    Object? price = null,
    Object? product = freezed,
    Object? variant = freezed,
    Object? itemStatus = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            quantity:
                null == quantity
                    ? _value.quantity
                    : quantity // ignore: cast_nullable_to_non_nullable
                        as int,
            price:
                null == price
                    ? _value.price
                    : price // ignore: cast_nullable_to_non_nullable
                        as double,
            product:
                freezed == product
                    ? _value.product
                    : product // ignore: cast_nullable_to_non_nullable
                        as Product?,
            variant:
                freezed == variant
                    ? _value.variant
                    : variant // ignore: cast_nullable_to_non_nullable
                        as ProductVariant?,
            itemStatus:
                freezed == itemStatus
                    ? _value.itemStatus
                    : itemStatus // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res>? get product {
    if (_value.product == null) {
      return null;
    }

    return $ProductCopyWith<$Res>(_value.product!, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductVariantCopyWith<$Res>? get variant {
    if (_value.variant == null) {
      return null;
    }

    return $ProductVariantCopyWith<$Res>(_value.variant!, (value) {
      return _then(_value.copyWith(variant: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderItemImplCopyWith<$Res>
    implements $OrderItemCopyWith<$Res> {
  factory _$$OrderItemImplCopyWith(
    _$OrderItemImpl value,
    $Res Function(_$OrderItemImpl) then,
  ) = __$$OrderItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(fromJson: stringToInt) int id,
    @JsonKey(fromJson: stringToInt) int quantity,
    @JsonKey(fromJson: stringToDouble) double price,
    Product? product,
    @JsonKey(name: 'ProductVariant') ProductVariant? variant,
    String? itemStatus,
  });

  @override
  $ProductCopyWith<$Res>? get product;
  @override
  $ProductVariantCopyWith<$Res>? get variant;
}

/// @nodoc
class __$$OrderItemImplCopyWithImpl<$Res>
    extends _$OrderItemCopyWithImpl<$Res, _$OrderItemImpl>
    implements _$$OrderItemImplCopyWith<$Res> {
  __$$OrderItemImplCopyWithImpl(
    _$OrderItemImpl _value,
    $Res Function(_$OrderItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? quantity = null,
    Object? price = null,
    Object? product = freezed,
    Object? variant = freezed,
    Object? itemStatus = freezed,
  }) {
    return _then(
      _$OrderItemImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        quantity:
            null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                    as int,
        price:
            null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                    as double,
        product:
            freezed == product
                ? _value.product
                : product // ignore: cast_nullable_to_non_nullable
                    as Product?,
        variant:
            freezed == variant
                ? _value.variant
                : variant // ignore: cast_nullable_to_non_nullable
                    as ProductVariant?,
        itemStatus:
            freezed == itemStatus
                ? _value.itemStatus
                : itemStatus // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderItemImpl implements _OrderItem {
  const _$OrderItemImpl({
    @JsonKey(fromJson: stringToInt) required this.id,
    @JsonKey(fromJson: stringToInt) required this.quantity,
    @JsonKey(fromJson: stringToDouble) required this.price,
    this.product,
    @JsonKey(name: 'ProductVariant') this.variant,
    this.itemStatus,
  });

  factory _$OrderItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderItemImplFromJson(json);

  @override
  @JsonKey(fromJson: stringToInt)
  final int id;
  @override
  @JsonKey(fromJson: stringToInt)
  final int quantity;
  @override
  @JsonKey(fromJson: stringToDouble)
  final double price;
  @override
  final Product? product;
  @override
  @JsonKey(name: 'ProductVariant')
  final ProductVariant? variant;
  @override
  final String? itemStatus;

  @override
  String toString() {
    return 'OrderItem(id: $id, quantity: $quantity, price: $price, product: $product, variant: $variant, itemStatus: $itemStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.variant, variant) || other.variant == variant) &&
            (identical(other.itemStatus, itemStatus) ||
                other.itemStatus == itemStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    quantity,
    price,
    product,
    variant,
    itemStatus,
  );

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderItemImplCopyWith<_$OrderItemImpl> get copyWith =>
      __$$OrderItemImplCopyWithImpl<_$OrderItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderItemImplToJson(this);
  }
}

abstract class _OrderItem implements OrderItem {
  const factory _OrderItem({
    @JsonKey(fromJson: stringToInt) required final int id,
    @JsonKey(fromJson: stringToInt) required final int quantity,
    @JsonKey(fromJson: stringToDouble) required final double price,
    final Product? product,
    @JsonKey(name: 'ProductVariant') final ProductVariant? variant,
    final String? itemStatus,
  }) = _$OrderItemImpl;

  factory _OrderItem.fromJson(Map<String, dynamic> json) =
      _$OrderItemImpl.fromJson;

  @override
  @JsonKey(fromJson: stringToInt)
  int get id;
  @override
  @JsonKey(fromJson: stringToInt)
  int get quantity;
  @override
  @JsonKey(fromJson: stringToDouble)
  double get price;
  @override
  Product? get product;
  @override
  @JsonKey(name: 'ProductVariant')
  ProductVariant? get variant;
  @override
  String? get itemStatus;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderItemImplCopyWith<_$OrderItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
