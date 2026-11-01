import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasources/remote/address_api.dart';
import '../data/models/address.dart';

import '../../../core/network/dio_client.dart';

// 1. API provider
final addressApiProvider = Provider<AddressApi>((ref) {
  final dio = ref.watch(dioProvider);
  return AddressApi(dio);
});

// 2. Address list provider
final addressesProvider = FutureProvider<List<Address>>((ref) async {
  final api = ref.read(addressApiProvider);
  final response = await api.getAddresses();
  // Backend returns { status: 'success', data: { addresses: [...] } }
  final List addressesJson = response['data']['addresses'];
  return addressesJson.map((json) => Address.fromJson(json)).toList();
});
// 3. Action notifier
class AddressActionNotifier extends StateNotifier<AsyncValue<void>> {
  final AddressApi _api;
  final Ref _ref;

  AddressActionNotifier(this._api, this._ref) : super(const AsyncValue.data(null));

  Future<void> addAddress({
    required String addressLine1,
    String? addressLine2,
    required String city,
    String? state, // Local parameter
    required String postalCode,
    required String country,
    bool isDefault = false,
  }) async {
    this.state = const AsyncValue.loading(); // Use this.state
    try {
      await _api.addAddress(
        addressLine1: addressLine1,
        addressLine2: addressLine2,
        city: city,
        state: state,
        postalCode: postalCode,
        country: country,
        isDefault: isDefault,
      );
      _ref.invalidate(addressesProvider);
      this.state = const AsyncValue.data(null); // Use this.state
    } catch (e, st) {
      this.state = AsyncValue.error(e, st); // Use this.state
    }
  }

  Future<void> updateAddress({
    required int id,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? state, // Local parameter
    String? postalCode,
    String? country,
    bool? isDefault,
  }) async {
    this.state = const AsyncValue.loading(); // Use this.state
    try {
      await _api.updateAddress(
        id: id,
        addressLine1: addressLine1,
        addressLine2: addressLine2,
        city: city,
        state: state,
        postalCode: postalCode,
        country: country,
        isDefault: isDefault,
      );
      _ref.invalidate(addressesProvider);
      this.state = const AsyncValue.data(null); // Use this.state
    } catch (e, st) {
      this.state = AsyncValue.error(e, st); // Use this.state
    }
  }

  Future<void> deleteAddress(int id) async {
    this.state = const AsyncValue.loading();
    try {
      await _api.deleteAddress(id);
      _ref.invalidate(addressesProvider);
      this.state = const AsyncValue.data(null);
    } catch (e, st) {
      this.state = AsyncValue.error(e, st);
    }
  }

  Future<void> setDefaultAddress(int id) async {
    this.state = const AsyncValue.loading();
    try {
      await _api.setDefaultAddress(id);
      _ref.invalidate(addressesProvider);
      this.state = const AsyncValue.data(null);
    } catch (e, st) {
      this.state = AsyncValue.error(e, st);
    }
  }
}final addressActionProvider =
    StateNotifierProvider<AddressActionNotifier, AsyncValue<void>>((ref) {
      final api = ref.read(addressApiProvider);
      return AddressActionNotifier(api, ref);
    });
