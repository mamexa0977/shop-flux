import 'package:dio/dio.dart';
import '../../../../core/constants/api_endpoints.dart'; // Adjust path if needed

class SearchApi {
  final Dio _dio;
  SearchApi(this._dio);
Future<void> recordSearch(String query) async {
  await _dio.post('${ApiEndpoints.search}/recent', data: {'query': query});
}
  Future<List<String>> getRecentSearches() async {
    final response = await _dio.get('${ApiEndpoints.search}/recent');
    // Assuming backend returns: { data: { recentSearches: ["shoes", "shirts"] } }
    final List<dynamic> searches = response.data['data']['recentSearches'];
    return searches.map((e) => e.toString()).toList();
  }

  Future<void> clearRecentSearches() async {
    await _dio.delete('${ApiEndpoints.search}/recent/clear');
  }

  // You will also have a function here to actually search for products
  Future<Map<String, dynamic>> searchProducts(String query) async {
    final response = await _dio.get('${ApiEndpoints.search}?q=$query');
    return response.data;
  }

  Future<List<dynamic>> getSuggestions(String query) async {
  final response = await _dio.get(
    '${ApiEndpoints.search}/suggest',
    queryParameters: {'q': query},
  );
  return response.data['data']['suggestions'];
}
}