import 'package:freezed_annotation/freezed_annotation.dart';

part 'banner.freezed.dart';
part 'banner.g.dart';

@freezed
class Banner with _$Banner {
  const factory Banner({
    required int id,
    String? title,
    String? description,
    required String imageUrl,
    String? link,
    String? buttonText,
    int? position,
    bool? isActive,
    DateTime? startDate,
    DateTime? endDate,
  }) = _Banner;

  factory Banner.fromJson(Map<String, dynamic> json) => _$BannerFromJson(json);
}