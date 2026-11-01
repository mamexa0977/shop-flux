import 'package:dio/dio.dart';
import '../../../../../core/constants/api_endpoints.dart';

class AddressApi {
  final Dio _dio;
  AddressApi(this._dio);

  // GET /addresses
  Future<Map<String, dynamic>> getAddresses() async {
    final response = await _dio.get(ApiEndpoints.addresses); // we'll define this endpoint
    return response.data;
  }

  // POST /addresses
  Future<Map<String, dynamic>> addAddress({
    required String addressLine1,
    String? addressLine2,
    required String city,
    String? state,
    required String postalCode,
    required String country,
    bool isDefault = false,
  }) async {
    final data = {
      'addressLine1': addressLine1,
      if (addressLine2 != null) 'addressLine2': addressLine2,
      'city': city,
      if (state != null) 'state': state,
      'postalCode': postalCode,
      'country': country,
      'isDefault': isDefault,
    };
    final response = await _dio.post(ApiEndpoints.addresses, data: data);
    return response.data;
  }

  // PATCH /addresses/:id
  Future<Map<String, dynamic>> updateAddress({
    required int id,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? state,
    String? postalCode,
    String? country,
    bool? isDefault,
  }) async {
    final data = <String, dynamic>{};
    if (addressLine1 != null) data['addressLine1'] = addressLine1;
    if (addressLine2 != null) data['addressLine2'] = addressLine2;
    if (city != null) data['city'] = city;
    if (state != null) data['state'] = state;
    if (postalCode != null) data['postalCode'] = postalCode;
    if (country != null) data['country'] = country;
    if (isDefault != null) data['isDefault'] = isDefault;

    final response = await _dio.patch('${ApiEndpoints.addresses}/$id', data: data);
    return response.data;
  }

  // DELETE /addresses/:id
  Future<void> deleteAddress(int id) async {
    await _dio.delete('${ApiEndpoints.addresses}/$id');
  }

  // PATCH /addresses/:id/default
  Future<Map<String, dynamic>> setDefaultAddress(int id) async {
    final response = await _dio.patch('${ApiEndpoints.addresses}/$id/default');
    return response.data;
  }
}