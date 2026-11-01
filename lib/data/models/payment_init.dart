import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_init.freezed.dart';
part 'payment_init.g.dart';

@freezed
class PaymentInit with _$PaymentInit {
  const factory PaymentInit({
    required String checkoutUrl,
  }) = _PaymentInit;

  factory PaymentInit.fromJson(Map<String, dynamic> json) =>
      _$PaymentInitFromJson(json);
}