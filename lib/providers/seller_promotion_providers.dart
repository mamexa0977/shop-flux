import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasources/remote/seller_promotion_api.dart';
import '../core/network/dio_client.dart';

final sellerPromotionApiProvider = Provider<SellerPromotionApi>((ref) {
  final dio = ref.watch(dioProvider);
  return SellerPromotionApi(dio);
});

// Discounts
final sellerDiscountsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final api = ref.watch(sellerPromotionApiProvider);
  final response = await api.getDiscounts();
  final List<dynamic> list = response['data']['discounts'];
  return list.cast<Map<String, dynamic>>();
});

// Flash Sales (available for participation)
final sellerAvailableFlashSalesProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final api = ref.watch(sellerPromotionApiProvider);
  final response = await api.getAvailableFlashSales();
  final List<dynamic> list = response['data']['flashSales'];
  return list.cast<Map<String, dynamic>>();
});

// Seller's own flash sale submissions
final sellerFlashSaleSubmissionsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final api = ref.watch(sellerPromotionApiProvider);
  final response = await api.getMyFlashSaleSubmissions();
  final List<dynamic> list = response['data']['submissions'];
  return list.cast<Map<String, dynamic>>();
});

// Action notifier for promotions
class SellerPromotionActionNotifier extends StateNotifier<AsyncValue<void>> {
  final SellerPromotionApi _api;
  final Ref _ref;

  SellerPromotionActionNotifier(this._api, this._ref) : super(const AsyncValue.data(null));

  Future<void> createDiscount(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      await _api.createDiscount(data);
      _ref.invalidate(sellerDiscountsProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateDiscount(int id, Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      await _api.updateDiscount(id, data);
      _ref.invalidate(sellerDiscountsProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteDiscount(int id) async {
    state = const AsyncValue.loading();
    try {
      await _api.deleteDiscount(id);
      _ref.invalidate(sellerDiscountsProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> participateInFlashSale(int flashSaleId, Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      await _api.participateInFlashSale(flashSaleId, data);
      _ref.invalidate(sellerFlashSaleSubmissionsProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final sellerPromotionActionProvider = StateNotifierProvider<SellerPromotionActionNotifier, AsyncValue<void>>((ref) {
  final api = ref.watch(sellerPromotionApiProvider);
  return SellerPromotionActionNotifier(api, ref);
});