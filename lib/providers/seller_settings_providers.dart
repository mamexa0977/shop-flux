import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasources/remote/seller_settings_api.dart';
import '../core/network/dio_client.dart';

final sellerSettingsApiProvider = Provider<SellerSettingsApi>((ref) {
  final dio = ref.watch(dioProvider);
  return SellerSettingsApi(dio);
});

final sellerStoreInfoProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final api = ref.watch(sellerSettingsApiProvider);
  final response = await api.getStoreInfo();
  return response['data']['store'] as Map<String, dynamic>;
});

class SellerSettingsActionNotifier extends StateNotifier<AsyncValue<void>> {
  final SellerSettingsApi _api;
  final Ref _ref;

  SellerSettingsActionNotifier(this._api, this._ref) : super(const AsyncValue.data(null));

  Future<void> updateStoreInfo(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      await _api.updateStoreInfo(data);
      _ref.invalidate(sellerStoreInfoProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateShippingSettings(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      await _api.updateShippingSettings(data);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final sellerSettingsActionProvider = StateNotifierProvider<SellerSettingsActionNotifier, AsyncValue<void>>((ref) {
  final api = ref.watch(sellerSettingsApiProvider);
  return SellerSettingsActionNotifier(api, ref);
});