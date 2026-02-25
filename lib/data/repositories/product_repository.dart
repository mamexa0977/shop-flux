import '../models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getFeaturedProducts();
  Future<List<Product>> getNewArrivals();
  Future<List<Product>> getBestSellers();
  Future<List<Product>> getProducts({int page = 1, int limit = 10, Map<String, dynamic>? filters});
  Future<Product> getProduct(int id);
  Future<List<Product>> getProductsByCategory(
    String slug, {
    int page = 1,
    int limit = 10,
    Map<String, dynamic>? filters,
  });
}