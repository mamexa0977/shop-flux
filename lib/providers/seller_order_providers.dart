import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasources/remote/seller_order_api.dart';
import '../data/models/order.dart';
import '../data/models/product.dart';
import '../data/models/return_request.dart';
import '../data/models/seller_order_group.dart'; // optional
import '../core/network/dio_client.dart';

// API provider
final sellerOrderApiProvider = Provider<SellerOrderApi>((ref) {
  final dio = ref.watch(dioProvider);
  return SellerOrderApi(dio);
});

// final sellerOrdersProvider = FutureProvider<List<Order>>((ref) async {
//   final api = ref.watch(sellerOrderApiProvider);
//   final response = await api.getOrders();
//   final List<dynamic> ordersJson = response['data']['orders'];
//   return ordersJson.map((json) => Order.fromJson(json)).toList();
// });
final sellerOrdersProvider = FutureProvider<List<SellerOrderGroup>>((ref) async {
  final api = ref.watch(sellerOrderApiProvider);
  final response = await api.getOrders();
  final List<dynamic> ordersJson = response['data']['orders'];
  return ordersJson.map((json) {
    return SellerOrderGroup(
      order: Order.fromJson(json),
      items: (json['items'] as List)
          .map((itemJson) => OrderItem.fromJson(itemJson))
          .toList(),
    );
  }).toList();
});

// Returns list provider
final sellerReturnsProvider = FutureProvider<List<ReturnRequest>>((ref) async {
  final api = ref.watch(sellerOrderApiProvider);
  final response = await api.getReturns();
  final List<dynamic> returnsJson = response['data']['returns'];
  return returnsJson.map((json) => ReturnRequest.fromJson(json)).toList();
});

// Inventory provider (list of products with stock)
final sellerInventoryProvider = FutureProvider<List<Product>>((ref) async {
  final api = ref.watch(sellerOrderApiProvider);
  final response = await api.getInventory();
  final List<dynamic> productsJson = response['data']['inventory'];
  return productsJson.map((json) => Product.fromJson(json)).toList();
});

// Action notifier for order item status updates
class SellerOrderActionNotifier extends StateNotifier<AsyncValue<void>> {
  final SellerOrderApi _api;
  final Ref _ref;

  SellerOrderActionNotifier(this._api, this._ref) : super(const AsyncValue.data(null));


  Future<bool> updateOrderItemStatus(int itemId, String status) async {
    state = const AsyncValue.loading();
    try {
      final response = await _api.updateOrderItemStatus(itemId, status);
      // Optionally extract updated item data if needed
      _ref.invalidate(sellerOrdersProvider);
      _ref.invalidate(sellerInventoryProvider);
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }}
Future<bool> updateOrderStatus(int orderId, String status) async {
  state = const AsyncValue.loading();
  try {
    await _api.updateOrderStatus(orderId, status);
    _ref.invalidate(sellerOrdersProvider);
    _ref.invalidate(sellerInventoryProvider);
    state = const AsyncValue.data(null);
    return true;
  } catch (e, st) {
    state = AsyncValue.error(e, st);
    return false;
  }
}
  Future<void> bulkUpdateStock(List<Map<String, dynamic>> updates) async {
    state = const AsyncValue.loading();
    try {
      await _api.bulkUpdateStock(updates);
      _ref.invalidate(sellerInventoryProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final sellerOrderActionProvider = StateNotifierProvider<SellerOrderActionNotifier, AsyncValue<void>>((ref) {
  final api = ref.watch(sellerOrderApiProvider);
  return SellerOrderActionNotifier(api, ref);
});