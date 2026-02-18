import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String phone,
    String? profileImage,
    @JsonKey(defaultValue: 'customer') String? role,
    @JsonKey(name: 'isPhoneVerified') bool? isPhoneVerified,
    // Seller fields
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
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}