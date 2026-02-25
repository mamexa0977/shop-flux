import 'package:dio/dio.dart';

import '../../../core/constants/api_endpoints.dart';

class WishlistApi {
  final Dio _dio;

  WishlistApi(this._dio);

  Future<Map<String, dynamic>> getWishlist() async {
    final response = await _dio.get(ApiEndpoints.wishlist);
    return response.data;
  }

  Future<void> addToWishlist(int productId) async {
  await _dio.post(
    ApiEndpoints.wishlist,
    data: {'productId': productId}, 
  );
}
  Future<void> removeWishlist(int productId) async {
  await _dio.delete('${ApiEndpoints.wishlist}/$productId');
}
}