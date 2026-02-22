import 'package:dio/dio.dart';

class PublicApi {
  final Dio _dio;

  PublicApi(this._dio);

  Future<Map<String, dynamic>> getBanners() async {
    final response = await _dio.get('/banners');
    return response.data;
  }

  Future<Map<String, dynamic>> getFlashSales() async {
    final response = await _dio.get('/flash-sales');
    return response.data;
  }
}