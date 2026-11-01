// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seller_order_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SellerOrderGroup _$SellerOrderGroupFromJson(Map<String, dynamic> json) {
  return _SellerOrderGroup.fromJson(json);
}

/// @nodoc
mixin _$SellerOrderGroup {
  Order get order => throw _privateConstructorUsedError;
  List<OrderItem> get items => throw _privateConstructorUsedError;

  /// Serializes this SellerOrderGroup to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SellerOrderGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SellerOrderGroupCopyWith<SellerOrderGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SellerOrderGroupCopyWith<$Res> {
  factory $SellerOrderGroupCopyWith(
    SellerOrderGroup value,
    $Res Function(SellerOrderGroup) then,
  ) = _$SellerOrderGroupCopyWithImpl<$Res, SellerOrderGroup>;
  @useResult
  $Res call({Order order, List<OrderItem> items});

  $OrderCopyWith<$Res> get order;
}

/// @nodoc
class _$SellerOrderGroupCopyWithImpl<$Res, $Val extends SellerOrderGroup>
    implements $SellerOrderGroupCopyWith<$Res> {
  _$SellerOrderGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SellerOrderGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? order = null, Object? items = null}) {
    return _then(
      _value.copyWith(
            order:
                null == order
                    ? _value.order
                    : order // ignore: cast_nullable_to_non_nullable
                        as Order,
            items:
                null == items
                    ? _value.items
                    : items // ignore: cast_nullable_to_non_nullable
                        as List<OrderItem>,
          )
          as $Val,
    );
  }

  /// Create a copy of SellerOrderGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderCopyWith<$Res> get order {
    return $OrderCopyWith<$Res>(_value.order, (value) {
      return _then(_value.copyWith(order: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SellerOrderGroupImplCopyWith<$Res>
    implements $SellerOrderGroupCopyWith<$Res> {
  factory _$$SellerOrderGroupImplCopyWith(
    _$SellerOrderGroupImpl value,
    $Res Function(_$SellerOrderGroupImpl) then,
  ) = __$$SellerOrderGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Order order, List<OrderItem> items});

  @override
  $OrderCopyWith<$Res> get order;
}

/// @nodoc
class __$$SellerOrderGroupImplCopyWithImpl<$Res>
    extends _$SellerOrderGroupCopyWithImpl<$Res, _$SellerOrderGroupImpl>
    implements _$$SellerOrderGroupImplCopyWith<$Res> {
  __$$SellerOrderGroupImplCopyWithImpl(
    _$SellerOrderGroupImpl _value,
    $Res Function(_$SellerOrderGroupImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SellerOrderGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? order = null, Object? items = null}) {
    return _then(
      _$SellerOrderGroupImpl(
        order:
            null == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                    as Order,
        items:
            null == items
                ? _value._items
                : items // ignore: cast_nullable_to_non_nullable
                    as List<OrderItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SellerOrderGroupImpl implements _SellerOrderGroup {
  const _$SellerOrderGroupImpl({
    required this.order,
    required final List<OrderItem> items,
  }) : _items = items;

  factory _$SellerOrderGroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$SellerOrderGroupImplFromJson(json);

  @override
  final Order order;
  final List<OrderItem> _items;
  @override
  List<OrderItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'SellerOrderGroup(order: $order, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SellerOrderGroupImpl &&
            (identical(other.order, order) || other.order == order) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    order,
    const DeepCollectionEquality().hash(_items),
  );

  /// Create a copy of SellerOrderGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SellerOrderGroupImplCopyWith<_$SellerOrderGroupImpl> get copyWith =>
      __$$SellerOrderGroupImplCopyWithImpl<_$SellerOrderGroupImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SellerOrderGroupImplToJson(this);
  }
}

abstract class _SellerOrderGroup implements SellerOrderGroup {
  const factory _SellerOrderGroup({
    required final Order order,
    required final List<OrderItem> items,
  }) = _$SellerOrderGroupImpl;

  factory _SellerOrderGroup.fromJson(Map<String, dynamic> json) =
      _$SellerOrderGroupImpl.fromJson;

  @override
  Order get order;
  @override
  List<OrderItem> get items;

  /// Create a copy of SellerOrderGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SellerOrderGroupImplCopyWith<_$SellerOrderGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
