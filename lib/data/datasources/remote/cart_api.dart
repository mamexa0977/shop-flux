import 'package:dio/dio.dart';

import '../../../core/constants/api_endpoints.dart';

// In cart_api.dart
class CartApi {
  final Dio _dio;
  CartApi(this._dio);

  Future<Map<String, dynamic>> getCart() async {
    await Future.delayed(const Duration(seconds: 5));

    final response = await _dio.get(ApiEndpoints.cart);
    return response.data;
  }

  Future<Map<String, dynamic>> addToCart(
    int productId,
    int? variantId,
    int quantity,
  ) async {
    final data = {'productId': productId, 'quantity': quantity};
    if (variantId != null) {
      data['variantId'] = variantId;
    }
    final response = await _dio.post('${ApiEndpoints.cart}/items', data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> updateCartItem(
    int cartItemId,
    int quantity,
  ) async {
    final response = await _dio.patch(
      '${ApiEndpoints.cart}/items/$cartItemId',
      data: {'quantity': quantity},
    );
    return response.data;
  }

  // Add remove, clear as needed
}
