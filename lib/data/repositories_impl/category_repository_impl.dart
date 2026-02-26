import '../models/category.dart';
import '../datasources/remote/category_api.dart';
import '../repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryApi _api;

  CategoryRepositoryImpl(this._api);

  @override
  Future<List<Category>> getCategories() async {
    await Future.delayed(const Duration(seconds: 10)); // Simulate network delay
    final response = await _api.getCategories();
    final data = response['data'];
    if (data is Map && data.containsKey('categories')) {
      return (data['categories'] as List).map((e) => Category.fromJson(e)).toList();
    }
    return [];
  }
}