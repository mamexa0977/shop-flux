// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../core/constants/api_endpoints.dart';
// import '../../../../data/models/product.dart';
// import '../../../../providers/wishlist_providers.dart';
// import 'package:ecom_frontend/providers/auth_state_provider.dart';

// import '../../../common_widgets/guest_prompt_view.dart';

// class WishlistScreen extends ConsumerWidget {
//   const WishlistScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final wishlistAsync = ref.watch(wishlistProvider);
//         final user = ref.watch(authStateProvider);

//      if (user == null) {
//       return const Scaffold(
//         body: GuestPromptView(title: 'Profile', icon: Icons.person),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(title: const Text('My Wishlist')),
//       body: wishlistAsync.when(
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (err, stack) => Center(child: Text('Error: $err')),
//         data: (wishlist) {
//           if (wishlist.isEmpty) {
//             return const Center(child: Text('Your wishlist is empty!'));
//           }

//           return ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: wishlist.length,
//             itemBuilder: (context, index) {
//               final item = wishlist[index];
//               final product = item.Product;

//               // Safely extract the primary image if it exists
//               String? imageUrl;
//               if (product?.ProductImages != null && product!.ProductImages!.isNotEmpty) {
//                  imageUrl = '${ApiEndpoints.baseUrl}/uploads/products/${product.ProductImages!.first.imageUrl}';
//               }

//               return Card(
//                 margin: const EdgeInsets.only(bottom: 12),
//                 child: ListTile(
//                   leading: Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       borderRadius: BorderRadius.circular(8),
//                       image: imageUrl != null
//                         ? DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover)
//                         : null,
//                     ),
//                     child: imageUrl == null ? const Icon(Icons.image_not_supported) : null,
//                   ),
//                   title: Text(product?.name ?? 'Unknown Product', style: const TextStyle(fontWeight: FontWeight.bold)),
//                   subtitle: Text('\$${product?.price ?? 0.0}'),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.favorite, color: Colors.red),
//                     onPressed: () {
//                       // TODO: Implement DELETE /wishlist/:productId in the future
//                     },
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../data/models/product.dart';
import '../../../../providers/wishlist_providers.dart';
import 'package:ecom_frontend/providers/auth_state_provider.dart';
import '../../../common_widgets/guest_prompt_view.dart';
import '../shimmer/wishlist_shimmer.dart';
import '../widget/wishlist_card.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistAsync = ref.watch(wishlistProvider);
    final user = ref.watch(authStateProvider);

    if (user == null) {
      return const Scaffold(
        body: GuestPromptView(title: 'Wishlist', icon: Icons.favorite_border),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => context.push('/cart'),
          ),
        ],
      ),
      body: wishlistAsync.when(
        loading: () => const WishlistSkeleton(),
        error:
            (err, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Something went wrong',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(err.toString(), textAlign: TextAlign.center),
                ],
              ),
            ),
        data: (wishlist) {
          if (wishlist.isEmpty) {
            return _buildEmptyState(context);
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: wishlist.length,
            itemBuilder: (context, index) {
              final item = wishlist[index];
              final product = item.Product;
              return WishlistCard(product: product);
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 100, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Your wishlist is empty',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Save your favourite items here and shop them later!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => context.push('/products'),
              icon: const Icon(Icons.shopping_bag),
              label: const Text('Start Shopping'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
