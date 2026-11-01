import 'package:ecom_frontend/core/constants/api_endpoints.dart';

class ImageUtils {
  static String getFullImageUrl(String? filename) {
    if (filename == null || filename.isEmpty) return '';
    // If it's already a full URL, return as is
    if (filename.startsWith('http')) return filename;
    // Otherwise, prepend base uploads URL
    return '${ApiEndpoints.baseUrl}/uploads/products/$filename';
  }
}