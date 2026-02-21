import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/utils/json_converters.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    @JsonKey(fromJson: stringToInt) required int id,
    required String name,
    required String phone,
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
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}