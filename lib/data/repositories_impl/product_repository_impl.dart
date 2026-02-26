import '../models/product.dart';
import '../models/review.dart'; // if needed
import '../datasources/remote/product_api.dart';
import '../repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductApi _api;

  ProductRepositoryImpl(this._api);

  @override
  Future<List<Product>> getFeaturedProducts() async {
    await Future.delayed(const Duration(seconds: 5));
    final response = await _api.getFeaturedProducts();
    return _extractProducts(response);
  }

  @override
  Future<List<Product>> getNewArrivals() async {
    final response = await _api.getNewArrivals();
    return _extractProducts(response);
  }

  @override
  Future<List<Product>> getBestSellers() async {
    final response = await _api.getBestSellers();
    return _extractProducts(response);
  }

  @override
  Future<List<Product>> getProducts({
    int page = 1,
    int limit = 10,
    Map<String, dynamic>? filters,
  }) async {
    final response = await _api.getProducts(
      page: page,
      limit: limit,
      filters: filters,
    );
    return _extractProducts(response);
  }

  @override
  Future<Product> getProduct(int id) async {
    final response = await _api.getProduct(id);
    return Product.fromJson(response['data']['product']);
  }

  @override
  Future<List<Product>> getProductsByCategory(
    String slug, {
    int page = 1,
    int limit = 10,
    Map<String, dynamic>? filters,
  }) async {
    await Future.delayed(const Duration(seconds: 5));
    final response = await _api.getProductsByCategory(
      slug,
      page: page,
      limit: limit,
      filters: filters,
    );
    return _extractProducts(response);
  }

  List<Product> _extractProducts(Map<String, dynamic> response) {
    final data = response['data'];
    if (data is Map && data.containsKey('products')) {
      return (data['products'] as List)
          .map((e) => Product.fromJson(e))
          .toList();
    }
    return [];
  }
}
