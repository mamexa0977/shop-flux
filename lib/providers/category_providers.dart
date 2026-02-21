import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasources/remote/category_api.dart';
import '../data/repositories/category_repository.dart';
import '../data/repositories_impl/category_repository_impl.dart';
import '../core/network/dio_client.dart';
import '../data/models/category.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final api = CategoryApi(dio);
  return CategoryRepositoryImpl(api);
});

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final repo = ref.read(categoryRepositoryProvider);
  return repo.getCategories();
});