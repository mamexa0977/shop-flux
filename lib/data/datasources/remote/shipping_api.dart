import 'package:dio/dio.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../models/shipping_rate.dart';

class ShippingApi {
  final Dio _dio;
  ShippingApi(this._dio);

  Future<List<ShippingRate>> calculateShipping({
    required String country,
    required double subtotal,
    required List<Map<String, dynamic>> items, // [{productId, quantity, weight?}]
  }) async {
    final response = await _dio.post(
      ApiEndpoints.calculateShipping,
      data: {
        'country': country,
        'subtotal': subtotal,
        'items': items,
      },
    );
    final data = response.data['data']['rates'] as List;
    return data.map((e) => ShippingRate.fromJson(e)).toList();
  }
}