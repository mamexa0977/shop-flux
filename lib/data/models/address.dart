import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class Address with _$Address {
  const factory Address({
    required int id,
    required String addressLine1,
    String? addressLine2,
    required String city,
    String? state,
    required String postalCode,
    required String country,
    @Default(false) bool isDefault,
    required int userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
}