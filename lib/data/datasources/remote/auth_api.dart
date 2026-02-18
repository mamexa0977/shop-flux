import 'package:dio/dio.dart';
 
import '../../../core/constants/api_endpoints.dart';
 

class AuthApi {
  final Dio _dio;

  AuthApi(this._dio);

  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiEndpoints.register, data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> registerSeller(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiEndpoints.registerSeller, data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> login(String phone, String password) async {
    final response = await _dio.post(
      ApiEndpoints.login,
      data: {'phone': phone, 'password': password},
    );
    return response.data;
  }

  Future<Map<String, dynamic>> forgotPassword(String phone) async {
    final response = await _dio.post(
      ApiEndpoints.forgotPassword,
      data: {'phone': phone},
    );
    return response.data;
  }

  Future<Map<String, dynamic>> resetPassword({
    required String phone,
    required String otp,
    required String newPassword,
  }) async {
    final response = await _dio.post(
      ApiEndpoints.resetPassword,
      data: {'phone': phone, 'otp': otp, 'newPassword': newPassword},
    );
    return response.data;
  }

  Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    final response = await _dio.post(
      ApiEndpoints.verifyOtp,
      data: {'phone': phone, 'otp': otp},
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getMe() async {
    final response = await _dio.get(ApiEndpoints.me);
    return response.data;
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    final response = await _dio.patch(ApiEndpoints.profile, data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final response = await _dio.post(
      ApiEndpoints.changePassword,
      data: {'currentPassword': currentPassword, 'newPassword': newPassword},
    );
    return response.data;
  }

  Future<Map<String, dynamic>> uploadProfileImage(FormData formData) async {
    final response = await _dio.post(
      ApiEndpoints.profileImage,
      data: formData,
      options: Options(headers: {'Content-Type': 'multipart/form-data'}),
    );
    print(
      'Upload Response#✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅#####################: ${response.data}',
    ); // Debugging line
    return response.data;
  }
}
