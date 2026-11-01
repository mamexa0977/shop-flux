import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../providers/cart_providers.dart';
import '../../../../providers/checkout_provider.dart';
import '../../../../providers/order_providers.dart';
import '../widgets/checkout_step.dart';
import 'address_selection_screen.dart';
import 'shipping_method_screen.dart';
import 'payment_method_screen.dart';
import 'order_confirmation_screen.dart';
import '../../../../data/models/order_request.dart';
import '../../../../data/models/address.dart';
import '../../../../data/models/shipping_rate.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final cartAsync = ref.watch(cartProvider);
    final checkout = ref.watch(checkoutProvider);
    final orderAsync = ref.watch(orderProvider);

    // When order is placed successfully, navigate to confirmation
    ref.listen(orderProvider, (previous, next) {
      next.whenOrNull(data: (response) {
        if (response != null) {
          // If Chapa, open webview; else go to confirmation
          if (response.payment != null) {
            _openChapaWebView(response.payment!.checkoutUrl);
          } else {
            context.go('/order-confirmation/${response.order.id}');
          }
        }
      });
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: cartAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (cart) {
          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    CheckoutStep(
                      number: 1,
                      title: 'Delivery Address',
                      isComplete: checkout.selectedAddress != null,
                      child: checkout.selectedAddress == null
                          ? _buildAddAddressButton()
                          : _buildAddressSummary(checkout.selectedAddress!),
                    ),
                    CheckoutStep(
                      number: 2,
                      title: 'Shipping Method',
                      isComplete: checkout.selectedShipping != null,
                      child: checkout.selectedShipping == null
                          ? _buildSelectShippingButton()
                          : _buildShippingSummary(checkout.selectedShipping!),
                    ),
                    CheckoutStep(
                      number: 3,
                      title: 'Payment Method',
                      isComplete: checkout.selectedPaymentMethod != null,
                      child: checkout.selectedPaymentMethod == null
                          ? _buildSelectPaymentButton()
                          : _buildPaymentSummary(checkout.selectedPaymentMethod!),
                    ),
                    const SizedBox(height: 20),
                    const Text('Order Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ...cart.items.map((item) => ListTile(
                      leading: Text('${item.quantity}x'),
                      title: Text(item.Product?.name ?? ''),
                      trailing: Text('\$${(item.Product?.price ?? 0) * item.quantity}'),
                    )),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal', style: TextStyle(fontSize: 16)),
                        Text('\$${cart.subtotal.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    if (checkout.selectedShipping != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Shipping', style: TextStyle(fontSize: 16)),
                          Text('\$${checkout.selectedShipping!.cost.toStringAsFixed(2)}'),
                        ],
                      ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(
                          '\$${(cart.subtotal + (checkout.selectedShipping?.cost ?? 0)).toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4, offset: const Offset(0, -2))],
                ),
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _canPlaceOrder(checkout) ? () => _placeOrder(cart) : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF015733),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: orderAsync.isLoading
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text('Place Order', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  bool _canPlaceOrder(CheckoutState checkout) {
    return checkout.selectedAddress != null &&
        checkout.selectedShipping != null &&
        checkout.selectedPaymentMethod != null;
  }

  Future<void> _placeOrder(cart) async {
    final notifier = ref.read(orderProvider.notifier);
    final checkout = ref.read(checkoutProvider);
    await notifier.placeOrder(OrderRequest(
      addressId: checkout.selectedAddress!.id,
      shippingMethod: checkout.selectedShipping!.name,
      paymentMethod: checkout.selectedPaymentMethod!,
    ));
  }

  void _openChapaWebView(String url) {
    // We'll implement a simple webview screen later
    context.push('/chapa-payment', extra: url);
  }

  Widget _buildAddAddressButton() {
    return ElevatedButton(
      onPressed: () async {
        final result = await Navigator.push<Address>(
          context,
          MaterialPageRoute(builder: (_) => const AddressSelectionScreen()),
        );
        if (result != null) {
          ref.read(checkoutProvider.notifier).setAddress(result);
        }
      },
      child: const Text('Select Address'),
    );
  }

  Widget _buildAddressSummary(Address address) {
    return ListTile(
      title: Text(address.addressLine1),
      subtitle: Text('${address.city}, ${address.country}'),
      trailing: TextButton(
        onPressed: () async {
          final result = await Navigator.push<Address>(
            context,
            MaterialPageRoute(builder: (_) => const AddressSelectionScreen()),
          );
          if (result != null) {
            ref.read(checkoutProvider.notifier).setAddress(result);
          }
        },
        child: const Text('Change'),
      ),
    );
  }

  Widget _buildSelectShippingButton() {
    return ElevatedButton(
      onPressed: () async {
        final result = await Navigator.push<ShippingRate>(
          context,
          MaterialPageRoute(builder: (_) => const ShippingMethodScreen()),
        );
        if (result != null) {
          ref.read(checkoutProvider.notifier).setShipping(result);
        }
      },
      child: const Text('Select Shipping'),
    );
  }

  Widget _buildShippingSummary(ShippingRate rate) {
    return ListTile(
      title: Text(rate.name),
      subtitle: Text('\$${rate.cost.toStringAsFixed(2)}'),
      trailing: TextButton(
        onPressed: () async {
          final result = await Navigator.push<ShippingRate>(
            context,
            MaterialPageRoute(builder: (_) => const ShippingMethodScreen()),
          );
          if (result != null) {
            ref.read(checkoutProvider.notifier).setShipping(result);
          }
        },
        child: const Text('Change'),
      ),
    );
  }

  Widget _buildSelectPaymentButton() {
    return ElevatedButton(
      onPressed: () async {
        final result = await Navigator.push<String>(
          context,
          MaterialPageRoute(builder: (_) => const PaymentMethodScreen()),
        );
        if (result != null) {
          ref.read(checkoutProvider.notifier).setPaymentMethod(result);
        }
      },
      child: const Text('Select Payment'),
    );
  }

  Widget _buildPaymentSummary(String method) {
    final display = method == 'chapa' ? 'Chapa (Online)' : 'Cash on Delivery';
    return ListTile(
      title: Text(display),
      trailing: TextButton(
        onPressed: () async {
          final result = await Navigator.push<String>(
            context,
            MaterialPageRoute(builder: (_) => const PaymentMethodScreen()),
          );
          if (result != null) {
            ref.read(checkoutProvider.notifier).setPaymentMethod(result);
          }
        },
        child: const Text('Change'),
      ),
    );
  }
}