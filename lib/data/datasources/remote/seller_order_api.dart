import 'package:dio/dio.dart';
import '../../../core/constants/api_endpoints.dart';

class SellerOrderApi {
  final Dio _dio;

  SellerOrderApi(this._dio);

  // Orders
  Future<Map<String, dynamic>> getOrders() async {
    final response = await _dio.get(ApiEndpoints.sellerOrders);
    return response.data;
  }

  Future<Map<String, dynamic>> getOrder(int id) async {
    final response = await _dio.get('${ApiEndpoints.sellerOrders}/$id');
    return response.data;
  }

  Future<Map<String, dynamic>> updateOrderItemStatus(int itemId, String status) async {
    final response = await _dio.patch(
      '${ApiEndpoints.sellerOrderItems}/$itemId/status',
      data: {'status': status},
    );
    return response.data;
  }
  Future<Map<String, dynamic>> updateOrderStatus(int orderId, String status) async {
  final response = await _dio.patch(
    '${ApiEndpoints.sellerOrders}/$orderId/status',
    data: {'status': status},
  );
  return response.data;
}

  // Returns
  Future<Map<String, dynamic>> getReturns() async {
    final response = await _dio.get(ApiEndpoints.sellerReturns);
    return response.data;
  }

  // Inventory (if separate endpoint exists)
  Future<Map<String, dynamic>> getInventory() async {
    final response = await _dio.get(ApiEndpoints.sellerInventory);
    return response.data;
  }

  Future<Map<String, dynamic>> bulkUpdateStock(List<Map<String, dynamic>> updates) async {
    final response = await _dio.post(
      ApiEndpoints.sellerBulkStock,
      data: {'updates': updates},
    );
    return response.data;
  }
}