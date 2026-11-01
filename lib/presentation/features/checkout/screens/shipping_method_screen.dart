import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/cart_providers.dart';
import '../../../../providers/checkout_provider.dart';
import '../../../../providers/shipping_providers.dart';
import '../../../../data/models/shipping_rate.dart';

class ShippingMethodScreen extends ConsumerStatefulWidget {
  const ShippingMethodScreen({super.key});

  @override
  ConsumerState<ShippingMethodScreen> createState() => _ShippingMethodScreenState();
}

class _ShippingMethodScreenState extends ConsumerState<ShippingMethodScreen> {
  ShippingRate? _selected;

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider).value;
    final address = ref.watch(checkoutProvider).selectedAddress;
    if (cart == null || address == null) {
      return const Scaffold(body: Center(child: Text('Missing information')));
    }

    // Use the new provider that depends on cart and address
    final ratesAsync = ref.watch(shippingRatesForCheckoutProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Shipping Method')),
      body: ratesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (rates) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: rates.length,
            itemBuilder: (ctx, i) {
              final rate = rates[i];
              return RadioListTile<ShippingRate>(
                title: Text(rate.name),
                subtitle: Text('\$${rate.cost.toStringAsFixed(2)}'),
                value: rate,
                groupValue: _selected,
                onChanged: (val) {
                  setState(() => _selected = val);
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _selected == null
              ? null
              : () => Navigator.pop(context, _selected),
          child: const Text('Continue'),
        ),
      ),
    );
  }
}