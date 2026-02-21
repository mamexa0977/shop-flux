import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../providers/product_providers.dart';
import '../../../../providers/review_providers.dart';
import '../../../common_widgets/error_view.dart';
import '../../../common_widgets/loading_indicator.dart';
import '../../../common_widgets/bottom_nav_bar.dart';
import '../widgets/variant_selector.dart';
import '../widgets/review_item.dart';

class ProductDetailScreen extends ConsumerWidget {
  final int productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productDetailProvider(productId));
    // final reviewsAsync = ref.watch(productReviewsProvider(productId));

    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: productAsync.when(
        loading: () => const LoadingIndicator(),
        error: (e, _) {
          print('❌ ProductDetail error: $e');
          return ErrorView(error: e.toString());
        },
        data: (product) {
          print('✅ Product loaded: ${product.id} - ${product.name}');
          print(
            '   Images: ${product.images?.map((img) => img.imageUrl).toList()}',
          );
          print(
            '   Seller: ${product.seller?.name} (profileImage: ${product.seller?.profileImage})',
          );
          print('   Variants: ${product.variants?.length}');
          print('   Reviews: ${product.reviews?.length}');

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image carousel with null safety
                SizedBox(
                  height: 300,
                  child:
                      (product.images != null && product.images!.isNotEmpty)
                          ? PageView(
                            children:
                                product.images!
                                    .where((img) => img.imageUrl != null)
                                    .map((img) {
                                      final url =
                                          '${ApiEndpoints.baseUrl}/uploads/profiles/${img.imageUrl}';
                                      print('   Loading image: $url');
                                      return Image.network(
                                        url,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stack) {
                                          print('❌ Image load error: $error');
                                          return const Center(
                                            child: Icon(Icons.broken_image),
                                          );
                                        },
                                        loadingBuilder: (
                                          context,
                                          child,
                                          loadingProgress,
                                        ) {
                                          if (loadingProgress == null)
                                            return child;
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                      );
                                    })
                                    .toList(),
                          )
                          : const Center(child: Icon(Icons.image, size: 50)),
                ),
                const SizedBox(height: 16),
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${product.discountPrice ?? product.price}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (product.discountPrice != null)
                  Text(
                    '\$${product.price}',
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                const SizedBox(height: 16),
                Text('Brand: ${product.brand ?? 'N/A'}'),
                const SizedBox(height: 8),
                Text('In Stock: ${product.stock ?? 0}'),
                const SizedBox(height: 16),
                if (product.variants != null && product.variants!.isNotEmpty)
                  VariantSelector(variants: product.variants!),
                const SizedBox(height: 16),
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(product.description ?? 'No description'),
                const Divider(height: 32),
                Text(
                  'Seller Info',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        product.seller?.profileImage != null
                            ? NetworkImage(
                              '${ApiEndpoints.baseUrl}/uploads/profiles/${product.seller!.profileImage}',
                            )
                            : null,
                    child:
                        product.seller?.profileImage == null
                            ? const Icon(Icons.person)
                            : null,
                  ),
                  title: Text(product.seller?.name ?? ''),
                ),
                const Divider(height: 32),
                Text('Reviews', style: Theme.of(context).textTheme.titleMedium),

                // ✅ REPLACE reviewsAsync.when(...) WITH THIS:
                if (product.reviews == null || product.reviews!.isEmpty)
                  const Text('No reviews yet')
                else
                  Column(
                    children:
                        product.reviews!
                            .map((r) => ReviewItem(review: r))
                            .toList(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
