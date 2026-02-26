import 'package:dio/dio.dart';

class PublicApi {
  final Dio _dio;

  PublicApi(this._dio);

  Future<Map<String, dynamic>> getBanners() async {
    await Future.delayed(const Duration(seconds: 5));

    final response = await _dio.get('/banners');
    return response.data;
  }

  Future<Map<String, dynamic>> getFlashSales() async {
    await Future.delayed(const Duration(seconds: 5));

    final response = await _dio.get('/flash-sales');
    return response.data;
  }
}