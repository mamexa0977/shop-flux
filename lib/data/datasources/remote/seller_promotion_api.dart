import 'package:dio/dio.dart';
import '../../../core/constants/api_endpoints.dart';

class SellerPromotionApi {
  final Dio _dio;

  SellerPromotionApi(this._dio);

  // Discounts
  Future<Map<String, dynamic>> getDiscounts() async {
    final response = await _dio.get(ApiEndpoints.sellerDiscounts);
    return response.data;
  }

  Future<Map<String, dynamic>> createDiscount(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiEndpoints.sellerDiscounts, data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> updateDiscount(int id, Map<String, dynamic> data) async {
    final response = await _dio.patch('${ApiEndpoints.sellerDiscounts}/$id', data: data);
    return response.data;
  }

  Future<void> deleteDiscount(int id) async {
    await _dio.delete('${ApiEndpoints.sellerDiscounts}/$id');
  }

  // Flash Sales
  Future<Map<String, dynamic>> getAvailableFlashSales() async {
    final response = await _dio.get(ApiEndpoints.sellerFlashSales);
    return response.data;
  }

  Future<Map<String, dynamic>> participateInFlashSale(int flashSaleId, Map<String, dynamic> data) async {
    final response = await _dio.post('${ApiEndpoints.sellerFlashSales}/$flashSaleId/participate', data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> getMyFlashSaleSubmissions() async {
    final response = await _dio.get(ApiEndpoints.sellerFlashSaleSubmissions);
    return response.data;
  }
}