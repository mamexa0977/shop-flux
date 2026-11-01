import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/network/dio_client.dart';
import '../data/datasources/remote/order_api.dart';
import '../data/models/order_request.dart';
import '../data/models/order.dart';
import '../data/models/order_response.dart';
import 'cart_providers.dart';
import 'checkout_provider.dart';

final orderApiProvider = Provider<OrderApi>((ref) {
  final dio = ref.watch(dioProvider);
  return OrderApi(dio);
});

// ---- Orders list provider (returns List<Order>) ----
final myOrdersProvider = FutureProvider<List<Order>>((ref) async {
  final api = ref.watch(orderApiProvider);
  return await api.getMyOrders();
});

// ---- Single order provider (returns Order) ----
final orderDetailsProvider = FutureProvider.family<Order, int>((ref, orderId) async {
  final api = ref.watch(orderApiProvider);
  return await api.getOrderById(orderId);
});

// ---- Action notifier ----
class OrderActionNotifier extends StateNotifier<AsyncValue<void>> {
  final OrderApi _api;
  final Ref _ref;

  OrderActionNotifier(this._api, this._ref) : super(const AsyncValue.data(null));

  Future<bool> cancelOrder(int orderId) async {
    state = const AsyncValue.loading();
    try {
      await _api.cancelOrder(orderId);
      _ref.invalidate(myOrdersProvider);
      _ref.invalidate(orderDetailsProvider(orderId));
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

Future<bool> requestReturn(int orderId, String reason, List<int> itemIds) async {
  state = const AsyncValue.loading();
  try {
    await _api.requestReturn(orderId, reason, itemIds);
    _ref.invalidate(myOrdersProvider);
    _ref.invalidate(orderDetailsProvider(orderId));
    state = const AsyncValue.data(null);
    return true;
  } catch (e, st) {
    state = AsyncValue.error(e, st);
    return false;
  }
}

  Future<String?> getInvoiceUrl(int orderId) async {
    state = const AsyncValue.loading();
    try {
      final url = await _api.getInvoiceUrl(orderId);
      state = const AsyncValue.data(null);
      return url;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }
}

final orderActionProvider = StateNotifierProvider<OrderActionNotifier, AsyncValue<void>>((ref) {
  final api = ref.watch(orderApiProvider);
  return OrderActionNotifier(api, ref);
});

// ---- OrderNotifier for placing order (returns OrderResponse) ----
class OrderNotifier extends StateNotifier<AsyncValue<OrderResponse?>> {
  final OrderApi _api;
  final Ref _ref;

  OrderNotifier(this._api, this._ref) : super(const AsyncValue.data(null));
Future<bool> requestReturn(int orderId, String reason, List<int> itemIds) async {
  state = const AsyncValue.loading();
  try {
    await _api.requestReturn(orderId, reason, itemIds);
    _ref.invalidate(myOrdersProvider);
    _ref.invalidate(orderDetailsProvider(orderId));
    state = const AsyncValue.data(null);
    return true;
  } catch (e, st) {
    state = AsyncValue.error(e, st);
    return false;
  }
}
  Future<void> placeOrder(OrderRequest request) async {
    state = const AsyncValue.loading();
    try {
      final response = await _api.createOrder(request);
      _ref.refresh(cartProvider);
      _ref.read(checkoutProvider.notifier).reset();
      _ref.invalidate(myOrdersProvider);
      state = AsyncValue.data(response);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void reset() => state = const AsyncValue.data(null);
}

final orderProvider = StateNotifierProvider<OrderNotifier, AsyncValue<OrderResponse?>>((ref) {
  final api = ref.read(orderApiProvider);
  return OrderNotifier(api, ref);
});