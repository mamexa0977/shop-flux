import 'package:dio/dio.dart';
import 'package:ecom_frontend/core/constants/api_endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../storage/secure_storage.dart';
import 'api_exception.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: ApiEndpoints.baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {'Content-Type': 'application/json'},
  ));

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      final token = await ref.read(secureStorageProvider).read(StorageKeys.token);
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    },
onError: (DioException e, handler) {
  print('Dio error: ${e.message}');
  if (e.response != null) {
    print('Response data: ${e.response?.data}');
    print('Status code: ${e.response?.statusCode}');
  }
  throw ApiException.fromDioError(e);
},
  ));

  return dio;
});