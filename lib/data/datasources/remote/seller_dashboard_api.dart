import 'package:dio/dio.dart';
import '../../../core/constants/api_endpoints.dart';

class SellerDashboardApi {
  final Dio _dio;

  SellerDashboardApi(this._dio);

  Future<Map<String, dynamic>> getDashboardStats() async {
    final response = await _dio.get(ApiEndpoints.sellerDashboard);
    return response.data;
  }
}