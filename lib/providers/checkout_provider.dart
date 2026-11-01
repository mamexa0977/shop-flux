import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/address.dart';
import '../data/models/shipping_rate.dart';

class CheckoutState {
  final Address? selectedAddress;
  final ShippingRate? selectedShipping;
  final String? selectedPaymentMethod; // 'chapa' or 'cash_on_delivery'

  CheckoutState({
    this.selectedAddress,
    this.selectedShipping,
    this.selectedPaymentMethod,
  });

  CheckoutState copyWith({
    Address? selectedAddress,
    ShippingRate? selectedShipping,
    String? selectedPaymentMethod,
  }) {
    return CheckoutState(
      selectedAddress: selectedAddress ?? this.selectedAddress,
      selectedShipping: selectedShipping ?? this.selectedShipping,
      selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
    );
  }
}

class CheckoutNotifier extends StateNotifier<CheckoutState> {
  CheckoutNotifier() : super(CheckoutState());

  void setAddress(Address address) {
    state = state.copyWith(selectedAddress: address);
  }

  void setShipping(ShippingRate shipping) {
    state = state.copyWith(selectedShipping: shipping);
  }

  void setPaymentMethod(String method) {
    state = state.copyWith(selectedPaymentMethod: method);
  }

  void reset() {
    state = CheckoutState();
  }
}

final checkoutProvider = StateNotifierProvider<CheckoutNotifier, CheckoutState>((ref) {
  return CheckoutNotifier();
});