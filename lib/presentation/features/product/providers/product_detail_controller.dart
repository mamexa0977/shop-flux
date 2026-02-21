import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailController extends StateNotifier<AsyncValue<void>> {
  ProductDetailController() : super(const AsyncValue.data(null));

  // Placeholder for future actions (add to cart, wishlist)
}

final productDetailControllerProvider = StateNotifierProvider<ProductDetailController, AsyncValue<void>>((ref) {
  return ProductDetailController();
});