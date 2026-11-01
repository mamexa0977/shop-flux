// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_init.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PaymentInit _$PaymentInitFromJson(Map<String, dynamic> json) {
  return _PaymentInit.fromJson(json);
}

/// @nodoc
mixin _$PaymentInit {
  String get checkoutUrl => throw _privateConstructorUsedError;

  /// Serializes this PaymentInit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentInit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentInitCopyWith<PaymentInit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentInitCopyWith<$Res> {
  factory $PaymentInitCopyWith(
    PaymentInit value,
    $Res Function(PaymentInit) then,
  ) = _$PaymentInitCopyWithImpl<$Res, PaymentInit>;
  @useResult
  $Res call({String checkoutUrl});
}

/// @nodoc
class _$PaymentInitCopyWithImpl<$Res, $Val extends PaymentInit>
    implements $PaymentInitCopyWith<$Res> {
  _$PaymentInitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentInit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? checkoutUrl = null}) {
    return _then(
      _value.copyWith(
            checkoutUrl:
                null == checkoutUrl
                    ? _value.checkoutUrl
                    : checkoutUrl // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaymentInitImplCopyWith<$Res>
    implements $PaymentInitCopyWith<$Res> {
  factory _$$PaymentInitImplCopyWith(
    _$PaymentInitImpl value,
    $Res Function(_$PaymentInitImpl) then,
  ) = __$$PaymentInitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String checkoutUrl});
}

/// @nodoc
class __$$PaymentInitImplCopyWithImpl<$Res>
    extends _$PaymentInitCopyWithImpl<$Res, _$PaymentInitImpl>
    implements _$$PaymentInitImplCopyWith<$Res> {
  __$$PaymentInitImplCopyWithImpl(
    _$PaymentInitImpl _value,
    $Res Function(_$PaymentInitImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentInit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? checkoutUrl = null}) {
    return _then(
      _$PaymentInitImpl(
        checkoutUrl:
            null == checkoutUrl
                ? _value.checkoutUrl
                : checkoutUrl // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentInitImpl implements _PaymentInit {
  const _$PaymentInitImpl({required this.checkoutUrl});

  factory _$PaymentInitImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentInitImplFromJson(json);

  @override
  final String checkoutUrl;

  @override
  String toString() {
    return 'PaymentInit(checkoutUrl: $checkoutUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentInitImpl &&
            (identical(other.checkoutUrl, checkoutUrl) ||
                other.checkoutUrl == checkoutUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, checkoutUrl);

  /// Create a copy of PaymentInit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentInitImplCopyWith<_$PaymentInitImpl> get copyWith =>
      __$$PaymentInitImplCopyWithImpl<_$PaymentInitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentInitImplToJson(this);
  }
}

abstract class _PaymentInit implements PaymentInit {
  const factory _PaymentInit({required final String checkoutUrl}) =
      _$PaymentInitImpl;

  factory _PaymentInit.fromJson(Map<String, dynamic> json) =
      _$PaymentInitImpl.fromJson;

  @override
  String get checkoutUrl;

  /// Create a copy of PaymentInit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentInitImplCopyWith<_$PaymentInitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
