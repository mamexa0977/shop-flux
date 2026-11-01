import 'package:dio/dio.dart';
import '../../../core/constants/api_endpoints.dart';

class SellerWalletApi {
  final Dio _dio;

  SellerWalletApi(this._dio);

  Future<Map<String, dynamic>> getWallet() async {
    final response = await _dio.get(ApiEndpoints.sellerWallet);
    return response.data;
  }

  Future<Map<String, dynamic>> requestWithdrawal(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiEndpoints.sellerWithdraw, data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> getWithdrawalHistory() async {
    final response = await _dio.get(ApiEndpoints.sellerWithdrawals);
    return response.data;
  }
}