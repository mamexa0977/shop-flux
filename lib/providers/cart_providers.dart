// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../data/datasources/remote/cart_api.dart';
// import '../data/models/cart.dart';
// import '../core/network/dio_client.dart';

// // 1. Provides the API instance
// final cartApiProvider = Provider<CartApi>((ref) {
//   final dio = ref.watch(dioProvider);
//   return CartApi(dio);
// });

// // 2. Fetches the Cart object (items + subtotal)
// final cartProvider = FutureProvider<CartData>((ref) async {
//   final api = ref.read(cartApiProvider);
//   final response = await api.getCart();
  
//   // Drilling down into { status: 'success', data: { cart: { ... } } }
//   final cartJson = response['data']['cart'];
//   return CartData.fromJson(cartJson);
// });
// cart_action_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasources/remote/cart_api.dart';
import '../data/models/cart.dart';
import '../core/network/dio_client.dart';

// 1. API provider
final cartApiProvider = Provider<CartApi>((ref) {
  final dio = ref.watch(dioProvider);
  return CartApi(dio);
});

// 2. Cart data provider
final cartProvider = FutureProvider<CartData>((ref) async {
  final api = ref.read(cartApiProvider);
  final response = await api.getCart();
  final cartJson = response['data']['cart'];
  return CartData.fromJson(cartJson);
});

// 3. Action notifier
class CartActionNotifier extends StateNotifier<AsyncValue<void>> {
  final CartApi _api;
  final Ref _ref;

  CartActionNotifier(this._api, this._ref) : super(const AsyncValue.data(null));

  Future<void> addItem(int productId, int? variantId, int quantity) async {
    state = const AsyncValue.loading();
    try {
      await _api.addToCart(productId, variantId, quantity);
      _ref.invalidate(cartProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateItem(int cartItemId, int quantity) async {
    state = const AsyncValue.loading();
    try {
      await _api.updateCartItem(cartItemId, quantity);
      _ref.invalidate(cartProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final cartActionProvider = StateNotifierProvider<CartActionNotifier, AsyncValue<void>>((ref) {
  final api = ref.read(cartApiProvider);
  return CartActionNotifier(api, ref);
});