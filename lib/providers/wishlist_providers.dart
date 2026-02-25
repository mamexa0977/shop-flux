import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasources/remote/wishlist_api.dart';
import '../data/models/wishlist.dart';
import '../core/network/dio_client.dart';

// 1. Provides the API instance
final wishlistApiProvider = Provider<WishlistApi>((ref) {
  final dio = ref.watch(dioProvider);
  return WishlistApi(dio);
});


// 2. Fetches and parses the list of wishlist items
final wishlistProvider = FutureProvider<List<WishlistItem>>((ref) async {
  final api = ref.read(wishlistApiProvider);
  final response = await api.getWishlist();
  
  // Drilling down into { status: 'success', data: { wishlist: [...] } }
  final data = response['data']['wishlist'] as List;
  return data.map((e) => WishlistItem.fromJson(e)).toList();
});
// Notifier to handle the "Action" of adding to wishlist
final wishlistActionProvider = AsyncNotifierProvider<WishlistActionNotifier, void>(() {
  return WishlistActionNotifier();
});

class WishlistActionNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> addItem(int productId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final api = ref.read(wishlistApiProvider);
      await api.addToWishlist(productId);
      // Refresh the wishlist list provider so the UI updates elsewhere
      ref.invalidate(wishlistProvider);
    });
  }

  Future<void> removeItem(int productId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final api = ref.read(wishlistApiProvider);
      await api.removeWishlist(productId);
      // Refresh the wishlist list provider so the UI updates elsewhere
      ref.invalidate(wishlistProvider);
    });
  }

}