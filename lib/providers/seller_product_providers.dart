import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../data/datasources/remote/seller_product_api.dart';
import '../core/network/dio_client.dart';
import '../data/models/product.dart'; // reuse existing Product model

// API provider
final sellerProductApiProvider = Provider<SellerProductApi>((ref) {
  final dio = ref.watch(dioProvider);
  return SellerProductApi(dio);
});

// List provider (auto-refreshes after actions)
final sellerProductListProvider = FutureProvider<List<Product>>((ref) async {
  final api = ref.watch(sellerProductApiProvider);
  final response = await api.getMyProducts();
  // response: { status: 'success', data: { products: [...] } }
  final List<dynamic> productsJson = response['data']['products'];
  return productsJson.map((json) => Product.fromJson(json)).toList();
});

// Action notifier for create/update/delete/stock/variants
class SellerProductActionNotifier extends StateNotifier<AsyncValue<void>> {
  final SellerProductApi _api;
  final Ref _ref;

  SellerProductActionNotifier(this._api, this._ref) : super(const AsyncValue.data(null));

  Future<void> createProduct(FormData formData) async {
    state = const AsyncValue.loading();
    try {
      await _api.createProduct(formData);
      _ref.invalidate(sellerProductListProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateProduct(int id, FormData formData) async {
    state = const AsyncValue.loading();
    try {
      await _api.updateProduct(id, formData);
      _ref.invalidate(sellerProductListProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteProduct(int id) async {
    state = const AsyncValue.loading();
    try {
      await _api.deleteProduct(id);
      _ref.invalidate(sellerProductListProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateStock(int productId, int stock) async {
    state = const AsyncValue.loading();
    try {
      await _api.updateStock(productId, stock);
      _ref.invalidate(sellerProductListProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addVariant(int productId, Map<String, dynamic> variantData) async {
    state = const AsyncValue.loading();
    try {
      await _api.addVariant(productId, variantData);
      _ref.invalidate(sellerProductListProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateVariant(int variantId, Map<String, dynamic> variantData) async {
    state = const AsyncValue.loading();
    try {
      await _api.updateVariant(variantId, variantData);
      _ref.invalidate(sellerProductListProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteVariant(int variantId) async {
    state = const AsyncValue.loading();
    try {
      await _api.deleteVariant(variantId);
      _ref.invalidate(sellerProductListProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final sellerProductActionProvider =
    StateNotifierProvider<SellerProductActionNotifier, AsyncValue<void>>((ref) {
  final api = ref.watch(sellerProductApiProvider);
  return SellerProductActionNotifier(api, ref);
});