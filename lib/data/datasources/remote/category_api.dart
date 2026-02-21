import 'package:dio/dio.dart';
import '../../../core/constants/api_endpoints.dart';

class CategoryApi {
  final Dio _dio;

  CategoryApi(this._dio);

  Future<Map<String, dynamic>> getCategories() async {
    final response = await _dio.get(ApiEndpoints.categories);
    return response.data;
  }
}