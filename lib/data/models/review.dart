import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';
import '../../core/utils/json_converters.dart';

part 'review.freezed.dart';
part 'review.g.dart';

@freezed
class Review with _$Review {
  const factory Review({
    @JsonKey(fromJson: stringToInt) required int id,
    @JsonKey(fromJson: stringToInt) required int rating,
    String? comment,
    @JsonKey(name: 'User') User? user,
    @JsonKey(name: 'createdAt') DateTime? createdAt,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) =>
      _$ReviewFromJson(json);
}