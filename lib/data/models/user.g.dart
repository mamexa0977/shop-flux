// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
  id: stringToInt(json['id']),
  name: json['name'] as String,
  phone: json['phone'] as String,
  profileImage: json['profileImage'] as String?,
  role: json['role'] as String? ?? 'customer',
  isPhoneVerified: json['isPhoneVerified'] as bool?,
  businessName: json['businessName'] as String?,
  businessRegNumber: json['businessRegNumber'] as String?,
  businessAddress: json['businessAddress'] as String?,
  businessPhone: json['businessPhone'] as String?,
  businessLogo: json['businessLogo'] as String?,
  bankName: json['bankName'] as String?,
  bankAccountName: json['bankAccountName'] as String?,
  bankAccountNumber: json['bankAccountNumber'] as String?,
  mobileMoneyProvider: json['mobileMoneyProvider'] as String?,
  mobileMoneyNumber: json['mobileMoneyNumber'] as String?,
  sellerStatus: json['sellerStatus'] as String?,
);

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'profileImage': instance.profileImage,
      'role': instance.role,
      'isPhoneVerified': instance.isPhoneVerified,
      'businessName': instance.businessName,
      'businessRegNumber': instance.businessRegNumber,
      'businessAddress': instance.businessAddress,
      'businessPhone': instance.businessPhone,
      'businessLogo': instance.businessLogo,
      'bankName': instance.bankName,
      'bankAccountName': instance.bankAccountName,
      'bankAccountNumber': instance.bankAccountNumber,
      'mobileMoneyProvider': instance.mobileMoneyProvider,
      'mobileMoneyNumber': instance.mobileMoneyNumber,
      'sellerStatus': instance.sellerStatus,
    };
