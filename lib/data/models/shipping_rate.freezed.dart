// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shipping_rate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ShippingRate _$ShippingRateFromJson(Map<String, dynamic> json) {
  return _ShippingRate.fromJson(json);
}

/// @nodoc
mixin _$ShippingRate {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(fromJson: stringToDouble, toJson: doubleToString)
  double get cost => throw _privateConstructorUsedError;
  String get rateType => throw _privateConstructorUsedError;

  /// Serializes this ShippingRate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShippingRate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShippingRateCopyWith<ShippingRate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShippingRateCopyWith<$Res> {
  factory $ShippingRateCopyWith(
    ShippingRate value,
    $Res Function(ShippingRate) then,
  ) = _$ShippingRateCopyWithImpl<$Res, ShippingRate>;
  @useResult
  $Res call({
    int id,
    String name,
    @JsonKey(fromJson: stringToDouble, toJson: doubleToString) double cost,
    String rateType,
  });
}

/// @nodoc
class _$ShippingRateCopyWithImpl<$Res, $Val extends ShippingRate>
    implements $ShippingRateCopyWith<$Res> {
  _$ShippingRateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShippingRate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? cost = null,
    Object? rateType = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            cost:
                null == cost
                    ? _value.cost
                    : cost // ignore: cast_nullable_to_non_nullable
                        as double,
            rateType:
                null == rateType
                    ? _value.rateType
                    : rateType // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShippingRateImplCopyWith<$Res>
    implements $ShippingRateCopyWith<$Res> {
  factory _$$ShippingRateImplCopyWith(
    _$ShippingRateImpl value,
    $Res Function(_$ShippingRateImpl) then,
  ) = __$$ShippingRateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    @JsonKey(fromJson: stringToDouble, toJson: doubleToString) double cost,
    String rateType,
  });
}

/// @nodoc
class __$$ShippingRateImplCopyWithImpl<$Res>
    extends _$ShippingRateCopyWithImpl<$Res, _$ShippingRateImpl>
    implements _$$ShippingRateImplCopyWith<$Res> {
  __$$ShippingRateImplCopyWithImpl(
    _$ShippingRateImpl _value,
    $Res Function(_$ShippingRateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShippingRate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? cost = null,
    Object? rateType = null,
  }) {
    return _then(
      _$ShippingRateImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        cost:
            null == cost
                ? _value.cost
                : cost // ignore: cast_nullable_to_non_nullable
                    as double,
        rateType:
            null == rateType
                ? _value.rateType
                : rateType // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShippingRateImpl implements _ShippingRate {
  const _$ShippingRateImpl({
    required this.id,
    required this.name,
    @JsonKey(fromJson: stringToDouble, toJson: doubleToString)
    required this.cost,
    required this.rateType,
  });

  factory _$ShippingRateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShippingRateImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(fromJson: stringToDouble, toJson: doubleToString)
  final double cost;
  @override
  final String rateType;

  @override
  String toString() {
    return 'ShippingRate(id: $id, name: $name, cost: $cost, rateType: $rateType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShippingRateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.rateType, rateType) ||
                other.rateType == rateType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, cost, rateType);

  /// Create a copy of ShippingRate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShippingRateImplCopyWith<_$ShippingRateImpl> get copyWith =>
      __$$ShippingRateImplCopyWithImpl<_$ShippingRateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShippingRateImplToJson(this);
  }
}

abstract class _ShippingRate implements ShippingRate {
  const factory _ShippingRate({
    required final int id,
    required final String name,
    @JsonKey(fromJson: stringToDouble, toJson: doubleToString)
    required final double cost,
    required final String rateType,
  }) = _$ShippingRateImpl;

  factory _ShippingRate.fromJson(Map<String, dynamic> json) =
      _$ShippingRateImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(fromJson: stringToDouble, toJson: doubleToString)
  double get cost;
  @override
  String get rateType;

  /// Create a copy of ShippingRate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShippingRateImplCopyWith<_$ShippingRateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
