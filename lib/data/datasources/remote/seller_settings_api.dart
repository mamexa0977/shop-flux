import 'package:dio/dio.dart';
import '../../../core/constants/api_endpoints.dart';

class SellerSettingsApi {
  final Dio _dio;

  SellerSettingsApi(this._dio);

  Future<Map<String, dynamic>> getStoreInfo() async {
    final response = await _dio.get(ApiEndpoints.sellerStoreSettings);
    return response.data;
  }

  Future<Map<String, dynamic>> updateStoreInfo(Map<String, dynamic> data) async {
    final response = await _dio.patch(ApiEndpoints.sellerStoreSettings, data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> updateShippingSettings(Map<String, dynamic> data) async {
    final response = await _dio.patch(ApiEndpoints.sellerShippingSettings, data: data);
    return response.data;
  }
}