import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/utils/json_converters.dart';

part 'return_request.freezed.dart';
part 'return_request.g.dart';

@freezed
class ReturnRequest with _$ReturnRequest {
  const factory ReturnRequest({
    @JsonKey(fromJson: stringToInt) required int id,
    String? reason,
    String? status,
    @JsonKey(name: 'orderId', fromJson: stringToInt) int? orderId,
    @JsonKey(fromJson: stringToDateTimeNullable) DateTime? createdAt,
  }) = _ReturnRequest;

  factory ReturnRequest.fromJson(Map<String, dynamic> json) => _$ReturnRequestFromJson(json);
}