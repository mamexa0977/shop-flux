import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/utils/json_converters.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
class Category with _$Category {
  const factory Category({
    @JsonKey(fromJson: stringToInt) required int id,
    required String name,
    required String slug,
    String? description,
    String? image,
    @JsonKey(fromJson: stringToIntNullable) int? parentId,
    @JsonKey(name: 'children') List<Category>? children,
    @JsonKey(name: 'isActive') bool? isActive,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}