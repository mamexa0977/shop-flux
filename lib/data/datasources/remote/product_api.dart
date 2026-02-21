import 'package:dio/dio.dart';
import '../../../core/constants/api_endpoints.dart';

class ProductApi {
  final Dio _dio;

  ProductApi(this._dio);

  Future<Map<String, dynamic>> getFeaturedProducts() async {
    final response = await _dio.get(ApiEndpoints.featuredProducts);
    return response.data;
  }

  Future<Map<String, dynamic>> getNewArrivals() async {
    final response = await _dio.get(ApiEndpoints.newArrivals);
    return response.data;
  }

  Future<Map<String, dynamic>> getBestSellers() async {
    final response = await _dio.get(ApiEndpoints.bestSellers);
    return response.data;
  }

  Future<Map<String, dynamic>> getProducts({
    int page = 1,
    int limit = 10,
    Map<String, dynamic>? filters,
  }) async {
    final query = <String, dynamic>{'page': page, 'limit': limit};
    if (filters != null) query.addAll(filters);
    final response = await _dio.get(
      ApiEndpoints.products,
      queryParameters: query,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getProduct(int id) async {
    final response = await _dio.get('${ApiEndpoints.productDetails}/$id');
    print('Product details response:🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀 ${response.data}');
    return response.data;
  }

  Future<Map<String, dynamic>> getProductsByCategory(String slug) async {
    final response = await _dio.get('${ApiEndpoints.productsByCategory}/$slug');
    return response.data;
  }
}
