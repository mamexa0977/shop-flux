// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'return_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ReturnRequest _$ReturnRequestFromJson(Map<String, dynamic> json) {
  return _ReturnRequest.fromJson(json);
}

/// @nodoc
mixin _$ReturnRequest {
  @JsonKey(fromJson: stringToInt)
  int get id => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'orderId', fromJson: stringToInt)
  int? get orderId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: stringToDateTimeNullable)
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ReturnRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReturnRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReturnRequestCopyWith<ReturnRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReturnRequestCopyWith<$Res> {
  factory $ReturnRequestCopyWith(
    ReturnRequest value,
    $Res Function(ReturnRequest) then,
  ) = _$ReturnRequestCopyWithImpl<$Res, ReturnRequest>;
  @useResult
  $Res call({
    @JsonKey(fromJson: stringToInt) int id,
    String? reason,
    String? status,
    @JsonKey(name: 'orderId', fromJson: stringToInt) int? orderId,
    @JsonKey(fromJson: stringToDateTimeNullable) DateTime? createdAt,
  });
}

/// @nodoc
class _$ReturnRequestCopyWithImpl<$Res, $Val extends ReturnRequest>
    implements $ReturnRequestCopyWith<$Res> {
  _$ReturnRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReturnRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? reason = freezed,
    Object? status = freezed,
    Object? orderId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            reason:
                freezed == reason
                    ? _value.reason
                    : reason // ignore: cast_nullable_to_non_nullable
                        as String?,
            status:
                freezed == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String?,
            orderId:
                freezed == orderId
                    ? _value.orderId
                    : orderId // ignore: cast_nullable_to_non_nullable
                        as int?,
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
abstract class _$$ReturnRequestImplCopyWith<$Res>
    implements $ReturnRequestCopyWith<$Res> {
  factory _$$ReturnRequestImplCopyWith(
    _$ReturnRequestImpl value,
    $Res Function(_$ReturnRequestImpl) then,
  ) = __$$ReturnRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(fromJson: stringToInt) int id,
    String? reason,
    String? status,
    @JsonKey(name: 'orderId', fromJson: stringToInt) int? orderId,
    @JsonKey(fromJson: stringToDateTimeNullable) DateTime? createdAt,
  });
}

/// @nodoc
class __$$ReturnRequestImplCopyWithImpl<$Res>
    extends _$ReturnRequestCopyWithImpl<$Res, _$ReturnRequestImpl>
    implements _$$ReturnRequestImplCopyWith<$Res> {
  __$$ReturnRequestImplCopyWithImpl(
    _$ReturnRequestImpl _value,
    $Res Function(_$ReturnRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReturnRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? reason = freezed,
    Object? status = freezed,
    Object? orderId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$ReturnRequestImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        reason:
            freezed == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                    as String?,
        status:
            freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String?,
        orderId:
            freezed == orderId
                ? _value.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                    as int?,
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
class _$ReturnRequestImpl implements _ReturnRequest {
  const _$ReturnRequestImpl({
    @JsonKey(fromJson: stringToInt) required this.id,
    this.reason,
    this.status,
    @JsonKey(name: 'orderId', fromJson: stringToInt) this.orderId,
    @JsonKey(fromJson: stringToDateTimeNullable) this.createdAt,
  });

  factory _$ReturnRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReturnRequestImplFromJson(json);

  @override
  @JsonKey(fromJson: stringToInt)
  final int id;
  @override
  final String? reason;
  @override
  final String? status;
  @override
  @JsonKey(name: 'orderId', fromJson: stringToInt)
  final int? orderId;
  @override
  @JsonKey(fromJson: stringToDateTimeNullable)
  final DateTime? createdAt;

  @override
  String toString() {
    return 'ReturnRequest(id: $id, reason: $reason, status: $status, orderId: $orderId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReturnRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, reason, status, orderId, createdAt);

  /// Create a copy of ReturnRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReturnRequestImplCopyWith<_$ReturnRequestImpl> get copyWith =>
      __$$ReturnRequestImplCopyWithImpl<_$ReturnRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReturnRequestImplToJson(this);
  }
}

abstract class _ReturnRequest implements ReturnRequest {
  const factory _ReturnRequest({
    @JsonKey(fromJson: stringToInt) required final int id,
    final String? reason,
    final String? status,
    @JsonKey(name: 'orderId', fromJson: stringToInt) final int? orderId,
    @JsonKey(fromJson: stringToDateTimeNullable) final DateTime? createdAt,
  }) = _$ReturnRequestImpl;

  factory _ReturnRequest.fromJson(Map<String, dynamic> json) =
      _$ReturnRequestImpl.fromJson;

  @override
  @JsonKey(fromJson: stringToInt)
  int get id;
  @override
  String? get reason;
  @override
  String? get status;
  @override
  @JsonKey(name: 'orderId', fromJson: stringToInt)
  int? get orderId;
  @override
  @JsonKey(fromJson: stringToDateTimeNullable)
  DateTime? get createdAt;

  /// Create a copy of ReturnRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReturnRequestImplCopyWith<_$ReturnRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
