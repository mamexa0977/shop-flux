import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  factory ApiException.fromDioError(DioException error) {
    String message;
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send timeout';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Receive timeout';
        break;
      case DioExceptionType.badCertificate:
        message = 'Bad certificate';
        break;
      case DioExceptionType.badResponse:
        message = _handleResponse(error.response);
        break;
      case DioExceptionType.cancel:
        message = 'Request cancelled';
        break;
      case DioExceptionType.connectionError:
        message = 'No internet connection';
        break;
      case DioExceptionType.unknown:
        message = 'Unexpected error occurred';
        break;
    }
    return ApiException(message: message, statusCode: error.response?.statusCode);
  }

  static String _handleResponse(Response? response) {
    if (response?.data is Map && response?.data['message'] != null) {
      return response?.data['message'];
    }
    return 'Server error (${response?.statusCode})';
  }

  @override
  String toString() => message;
}