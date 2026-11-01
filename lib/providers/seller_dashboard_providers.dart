import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasources/remote/seller_dashboard_api.dart'; // fixed filename
import '../core/network/dio_client.dart';

final sellerDashboardApiProvider = Provider<SellerDashboardApi>((ref) {
  final dio = ref.watch(dioProvider);
  return SellerDashboardApi(dio);
});

// Auto-refresh every 30 seconds (optional)
final sellerDashboardProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.watch(sellerDashboardApiProvider);
  final response = await api.getDashboardStats();
  // backend returns { status: 'success', data: { ... } }
  return response['data'] as Map<String, dynamic>;
});