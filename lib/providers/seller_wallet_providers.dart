import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasources/remote/seller_wallet_api.dart';
import '../core/network/dio_client.dart';

final sellerWalletApiProvider = Provider<SellerWalletApi>((ref) {
  final dio = ref.watch(dioProvider);
  return SellerWalletApi(dio);
});

// Wallet data provider
final sellerWalletProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final api = ref.watch(sellerWalletApiProvider);
  final response = await api.getWallet();
  return response['data']['wallet'] as Map<String, dynamic>;
});

// Withdrawal history provider
final sellerWithdrawalHistoryProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final api = ref.watch(sellerWalletApiProvider);
  final response = await api.getWithdrawalHistory();
  final List<dynamic> list = response['data']['withdrawals'];
  return list.cast<Map<String, dynamic>>();
});

// Action notifier for withdrawal request
class SellerWalletActionNotifier extends StateNotifier<AsyncValue<void>> {
  final SellerWalletApi _api;
  final Ref _ref;

  SellerWalletActionNotifier(this._api, this._ref) : super(const AsyncValue.data(null));

  Future<void> requestWithdrawal(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      await _api.requestWithdrawal(data);
      _ref.invalidate(sellerWalletProvider);
      _ref.invalidate(sellerWithdrawalHistoryProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final sellerWalletActionProvider = StateNotifierProvider<SellerWalletActionNotifier, AsyncValue<void>>((ref) {
  final api = ref.watch(sellerWalletApiProvider);
  return SellerWalletActionNotifier(api, ref);
});