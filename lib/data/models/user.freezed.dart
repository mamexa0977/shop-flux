// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  @JsonKey(fromJson: stringToInt)
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String? get profileImage => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: 'customer')
  String? get role => throw _privateConstructorUsedError;
  @JsonKey(name: 'isPhoneVerified')
  bool? get isPhoneVerified => throw _privateConstructorUsedError;
  String? get businessName => throw _privateConstructorUsedError;
  String? get businessRegNumber => throw _privateConstructorUsedError;
  String? get businessAddress => throw _privateConstructorUsedError;
  String? get businessPhone => throw _privateConstructorUsedError;
  String? get businessLogo => throw _privateConstructorUsedError;
  String? get bankName => throw _privateConstructorUsedError;
  String? get bankAccountName => throw _privateConstructorUsedError;
  String? get bankAccountNumber => throw _privateConstructorUsedError;
  String? get mobileMoneyProvider => throw _privateConstructorUsedError;
  String? get mobileMoneyNumber => throw _privateConstructorUsedError;
  String? get sellerStatus => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call({
    @JsonKey(fromJson: stringToInt) int id,
    String name,
    String phone,
    String? profileImage,
    @JsonKey(defaultValue: 'customer') String? role,
    @JsonKey(name: 'isPhoneVerified') bool? isPhoneVerified,
    String? businessName,
    String? businessRegNumber,
    String? businessAddress,
    String? businessPhone,
    String? businessLogo,
    String? bankName,
    String? bankAccountName,
    String? bankAccountNumber,
    String? mobileMoneyProvider,
    String? mobileMoneyNumber,
    String? sellerStatus,
  });
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
    Object? profileImage = freezed,
    Object? role = freezed,
    Object? isPhoneVerified = freezed,
    Object? businessName = freezed,
    Object? businessRegNumber = freezed,
    Object? businessAddress = freezed,
    Object? businessPhone = freezed,
    Object? businessLogo = freezed,
    Object? bankName = freezed,
    Object? bankAccountName = freezed,
    Object? bankAccountNumber = freezed,
    Object? mobileMoneyProvider = freezed,
    Object? mobileMoneyNumber = freezed,
    Object? sellerStatus = freezed,
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
            phone:
                null == phone
                    ? _value.phone
                    : phone // ignore: cast_nullable_to_non_nullable
                        as String,
            profileImage:
                freezed == profileImage
                    ? _value.profileImage
                    : profileImage // ignore: cast_nullable_to_non_nullable
                        as String?,
            role:
                freezed == role
                    ? _value.role
                    : role // ignore: cast_nullable_to_non_nullable
                        as String?,
            isPhoneVerified:
                freezed == isPhoneVerified
                    ? _value.isPhoneVerified
                    : isPhoneVerified // ignore: cast_nullable_to_non_nullable
                        as bool?,
            businessName:
                freezed == businessName
                    ? _value.businessName
                    : businessName // ignore: cast_nullable_to_non_nullable
                        as String?,
            businessRegNumber:
                freezed == businessRegNumber
                    ? _value.businessRegNumber
                    : businessRegNumber // ignore: cast_nullable_to_non_nullable
                        as String?,
            businessAddress:
                freezed == businessAddress
                    ? _value.businessAddress
                    : businessAddress // ignore: cast_nullable_to_non_nullable
                        as String?,
            businessPhone:
                freezed == businessPhone
                    ? _value.businessPhone
                    : businessPhone // ignore: cast_nullable_to_non_nullable
                        as String?,
            businessLogo:
                freezed == businessLogo
                    ? _value.businessLogo
                    : businessLogo // ignore: cast_nullable_to_non_nullable
                        as String?,
            bankName:
                freezed == bankName
                    ? _value.bankName
                    : bankName // ignore: cast_nullable_to_non_nullable
                        as String?,
            bankAccountName:
                freezed == bankAccountName
                    ? _value.bankAccountName
                    : bankAccountName // ignore: cast_nullable_to_non_nullable
                        as String?,
            bankAccountNumber:
                freezed == bankAccountNumber
                    ? _value.bankAccountNumber
                    : bankAccountNumber // ignore: cast_nullable_to_non_nullable
                        as String?,
            mobileMoneyProvider:
                freezed == mobileMoneyProvider
                    ? _value.mobileMoneyProvider
                    : mobileMoneyProvider // ignore: cast_nullable_to_non_nullable
                        as String?,
            mobileMoneyNumber:
                freezed == mobileMoneyNumber
                    ? _value.mobileMoneyNumber
                    : mobileMoneyNumber // ignore: cast_nullable_to_non_nullable
                        as String?,
            sellerStatus:
                freezed == sellerStatus
                    ? _value.sellerStatus
                    : sellerStatus // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
    _$UserImpl value,
    $Res Function(_$UserImpl) then,
  ) = __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(fromJson: stringToInt) int id,
    String name,
    String phone,
    String? profileImage,
    @JsonKey(defaultValue: 'customer') String? role,
    @JsonKey(name: 'isPhoneVerified') bool? isPhoneVerified,
    String? businessName,
    String? businessRegNumber,
    String? businessAddress,
    String? businessPhone,
    String? businessLogo,
    String? bankName,
    String? bankAccountName,
    String? bankAccountNumber,
    String? mobileMoneyProvider,
    String? mobileMoneyNumber,
    String? sellerStatus,
  });
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
    : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
    Object? profileImage = freezed,
    Object? role = freezed,
    Object? isPhoneVerified = freezed,
    Object? businessName = freezed,
    Object? businessRegNumber = freezed,
    Object? businessAddress = freezed,
    Object? businessPhone = freezed,
    Object? businessLogo = freezed,
    Object? bankName = freezed,
    Object? bankAccountName = freezed,
    Object? bankAccountNumber = freezed,
    Object? mobileMoneyProvider = freezed,
    Object? mobileMoneyNumber = freezed,
    Object? sellerStatus = freezed,
  }) {
    return _then(
      _$UserImpl(
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
        phone:
            null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                    as String,
        profileImage:
            freezed == profileImage
                ? _value.profileImage
                : profileImage // ignore: cast_nullable_to_non_nullable
                    as String?,
        role:
            freezed == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                    as String?,
        isPhoneVerified:
            freezed == isPhoneVerified
                ? _value.isPhoneVerified
                : isPhoneVerified // ignore: cast_nullable_to_non_nullable
                    as bool?,
        businessName:
            freezed == businessName
                ? _value.businessName
                : businessName // ignore: cast_nullable_to_non_nullable
                    as String?,
        businessRegNumber:
            freezed == businessRegNumber
                ? _value.businessRegNumber
                : businessRegNumber // ignore: cast_nullable_to_non_nullable
                    as String?,
        businessAddress:
            freezed == businessAddress
                ? _value.businessAddress
                : businessAddress // ignore: cast_nullable_to_non_nullable
                    as String?,
        businessPhone:
            freezed == businessPhone
                ? _value.businessPhone
                : businessPhone // ignore: cast_nullable_to_non_nullable
                    as String?,
        businessLogo:
            freezed == businessLogo
                ? _value.businessLogo
                : businessLogo // ignore: cast_nullable_to_non_nullable
                    as String?,
        bankName:
            freezed == bankName
                ? _value.bankName
                : bankName // ignore: cast_nullable_to_non_nullable
                    as String?,
        bankAccountName:
            freezed == bankAccountName
                ? _value.bankAccountName
                : bankAccountName // ignore: cast_nullable_to_non_nullable
                    as String?,
        bankAccountNumber:
            freezed == bankAccountNumber
                ? _value.bankAccountNumber
                : bankAccountNumber // ignore: cast_nullable_to_non_nullable
                    as String?,
        mobileMoneyProvider:
            freezed == mobileMoneyProvider
                ? _value.mobileMoneyProvider
                : mobileMoneyProvider // ignore: cast_nullable_to_non_nullable
                    as String?,
        mobileMoneyNumber:
            freezed == mobileMoneyNumber
                ? _value.mobileMoneyNumber
                : mobileMoneyNumber // ignore: cast_nullable_to_non_nullable
                    as String?,
        sellerStatus:
            freezed == sellerStatus
                ? _value.sellerStatus
                : sellerStatus // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl({
    @JsonKey(fromJson: stringToInt) required this.id,
    required this.name,
    required this.phone,
    this.profileImage,
    @JsonKey(defaultValue: 'customer') this.role,
    @JsonKey(name: 'isPhoneVerified') this.isPhoneVerified,
    this.businessName,
    this.businessRegNumber,
    this.businessAddress,
    this.businessPhone,
    this.businessLogo,
    this.bankName,
    this.bankAccountName,
    this.bankAccountNumber,
    this.mobileMoneyProvider,
    this.mobileMoneyNumber,
    this.sellerStatus,
  });

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  @JsonKey(fromJson: stringToInt)
  final int id;
  @override
  final String name;
  @override
  final String phone;
  @override
  final String? profileImage;
  @override
  @JsonKey(defaultValue: 'customer')
  final String? role;
  @override
  @JsonKey(name: 'isPhoneVerified')
  final bool? isPhoneVerified;
  @override
  final String? businessName;
  @override
  final String? businessRegNumber;
  @override
  final String? businessAddress;
  @override
  final String? businessPhone;
  @override
  final String? businessLogo;
  @override
  final String? bankName;
  @override
  final String? bankAccountName;
  @override
  final String? bankAccountNumber;
  @override
  final String? mobileMoneyProvider;
  @override
  final String? mobileMoneyNumber;
  @override
  final String? sellerStatus;

  @override
  String toString() {
    return 'User(id: $id, name: $name, phone: $phone, profileImage: $profileImage, role: $role, isPhoneVerified: $isPhoneVerified, businessName: $businessName, businessRegNumber: $businessRegNumber, businessAddress: $businessAddress, businessPhone: $businessPhone, businessLogo: $businessLogo, bankName: $bankName, bankAccountName: $bankAccountName, bankAccountNumber: $bankAccountNumber, mobileMoneyProvider: $mobileMoneyProvider, mobileMoneyNumber: $mobileMoneyNumber, sellerStatus: $sellerStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.isPhoneVerified, isPhoneVerified) ||
                other.isPhoneVerified == isPhoneVerified) &&
            (identical(other.businessName, businessName) ||
                other.businessName == businessName) &&
            (identical(other.businessRegNumber, businessRegNumber) ||
                other.businessRegNumber == businessRegNumber) &&
            (identical(other.businessAddress, businessAddress) ||
                other.businessAddress == businessAddress) &&
            (identical(other.businessPhone, businessPhone) ||
                other.businessPhone == businessPhone) &&
            (identical(other.businessLogo, businessLogo) ||
                other.businessLogo == businessLogo) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.bankAccountName, bankAccountName) ||
                other.bankAccountName == bankAccountName) &&
            (identical(other.bankAccountNumber, bankAccountNumber) ||
                other.bankAccountNumber == bankAccountNumber) &&
            (identical(other.mobileMoneyProvider, mobileMoneyProvider) ||
                other.mobileMoneyProvider == mobileMoneyProvider) &&
            (identical(other.mobileMoneyNumber, mobileMoneyNumber) ||
                other.mobileMoneyNumber == mobileMoneyNumber) &&
            (identical(other.sellerStatus, sellerStatus) ||
                other.sellerStatus == sellerStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    phone,
    profileImage,
    role,
    isPhoneVerified,
    businessName,
    businessRegNumber,
    businessAddress,
    businessPhone,
    businessLogo,
    bankName,
    bankAccountName,
    bankAccountNumber,
    mobileMoneyProvider,
    mobileMoneyNumber,
    sellerStatus,
  );

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(this);
  }
}

abstract class _User implements User {
  const factory _User({
    @JsonKey(fromJson: stringToInt) required final int id,
    required final String name,
    required final String phone,
    final String? profileImage,
    @JsonKey(defaultValue: 'customer') final String? role,
    @JsonKey(name: 'isPhoneVerified') final bool? isPhoneVerified,
    final String? businessName,
    final String? businessRegNumber,
    final String? businessAddress,
    final String? businessPhone,
    final String? businessLogo,
    final String? bankName,
    final String? bankAccountName,
    final String? bankAccountNumber,
    final String? mobileMoneyProvider,
    final String? mobileMoneyNumber,
    final String? sellerStatus,
  }) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  @JsonKey(fromJson: stringToInt)
  int get id;
  @override
  String get name;
  @override
  String get phone;
  @override
  String? get profileImage;
  @override
  @JsonKey(defaultValue: 'customer')
  String? get role;
  @override
  @JsonKey(name: 'isPhoneVerified')
  bool? get isPhoneVerified;
  @override
  String? get businessName;
  @override
  String? get businessRegNumber;
  @override
  String? get businessAddress;
  @override
  String? get businessPhone;
  @override
  String? get businessLogo;
  @override
  String? get bankName;
  @override
  String? get bankAccountName;
  @override
  String? get bankAccountNumber;
  @override
  String? get mobileMoneyProvider;
  @override
  String? get mobileMoneyNumber;
  @override
  String? get sellerStatus;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
