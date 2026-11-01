import 'package:dio/dio.dart';
import '../../../core/constants/api_endpoints.dart';

class SellerProductApi {
  final Dio _dio;

  SellerProductApi(this._dio);

  // Product CRUD
  Future<Map<String, dynamic>> getMyProducts() async {
    final response = await _dio.get(ApiEndpoints.sellerProducts);
    return response.data;
  }

  Future<Map<String, dynamic>> getProduct(int id) async {
    final response = await _dio.get('${ApiEndpoints.sellerProducts}/$id');
    return response.data;
  }

  Future<Map<String, dynamic>> createProduct(FormData formData) async {
    final response = await _dio.post(
      ApiEndpoints.sellerProducts,
      data: formData,
      options: Options(headers: {'Content-Type': 'multipart/form-data'}),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> updateProduct(int id, FormData formData) async {
    final response = await _dio.patch(
      '${ApiEndpoints.sellerProducts}/$id',
      data: formData,
      options: Options(headers: {'Content-Type': 'multipart/form-data'}),
    );
    return response.data;
  }

  Future<void> deleteProduct(int id) async {
    await _dio.delete('${ApiEndpoints.sellerProducts}/$id');
  }

  // Stock update
  Future<Map<String, dynamic>> updateStock(int productId, int stock) async {
    final response = await _dio.patch(
      '${ApiEndpoints.sellerProducts}/$productId/stock',
      data: {'stock': stock},
    );
    return response.data;
  }

  // Variant management
  Future<Map<String, dynamic>> addVariant(int productId, Map<String, dynamic> data) async {
    final response = await _dio.post(
      '${ApiEndpoints.sellerProducts}/$productId/variants',
      data: data,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> updateVariant(int variantId, Map<String, dynamic> data) async {
    final response = await _dio.patch(
      '${ApiEndpoints.sellerVariants}/$variantId',
      data: data,
    );
    return response.data;
  }

  Future<void> deleteVariant(int variantId) async {
    await _dio.delete('${ApiEndpoints.sellerVariants}/$variantId');
  }
}