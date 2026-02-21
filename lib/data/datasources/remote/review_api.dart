import 'package:dio/dio.dart';
import '../../../../core/constants/api_endpoints.dart';

class ReviewApi {
  final Dio _dio;

  ReviewApi(this._dio);

  Future<Map<String, dynamic>> getProductReviews(int productId) async {
    final response = await _dio.get('${ApiEndpoints.productReviews}/$productId');
    return response.data;
  }
}