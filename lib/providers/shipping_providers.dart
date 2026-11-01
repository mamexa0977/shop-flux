import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/network/dio_client.dart';
import '../data/datasources/remote/shipping_api.dart';
import '../data/models/shipping_rate.dart';
import 'cart_providers.dart';
import 'checkout_provider.dart';

final shippingApiProvider = Provider<ShippingApi>((ref) {
  final dio = ref.watch(dioProvider);
  return ShippingApi(dio);
});

// Original family provider (kept for flexibility)
final shippingRatesProvider = FutureProvider.family<List<ShippingRate>, Map<String, dynamic>>((ref, params) async {
  final api = ref.read(shippingApiProvider);
  return api.calculateShipping(
    country: params['country'],
    subtotal: params['subtotal'],
    items: params['items'],
  );
});

// New provider that automatically fetches based on cart and address
final shippingRatesForCheckoutProvider = FutureProvider<List<ShippingRate>>((ref) async {
  final cartValue = ref.watch(cartProvider).value;
  final address = ref.watch(checkoutProvider).selectedAddress;

  if (cartValue == null || address == null) {
    throw Exception('Missing cart or address');
  }

  final api = ref.read(shippingApiProvider);
  return api.calculateShipping(
    country: address.country,
    subtotal: cartValue.subtotal,
    items: cartValue.items.map((item) => {
      'productId': item.productId,
      'quantity': item.quantity,
    }).toList(),
  );
});