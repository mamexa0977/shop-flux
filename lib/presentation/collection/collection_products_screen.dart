// lib/presentation/collection/collection_products_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/enums/collection_type.dart';
import '../../providers/product_providers.dart';
import '../common_widgets/product_card.dart';
import '../common_widgets/error_view.dart';

class CollectionProductsScreen extends ConsumerWidget {
  final CollectionType collectionType;

  const CollectionProductsScreen({super.key, required this.collectionType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Select the correct provider based on collection type
    final productsAsync = ref.watch(
      collectionType == CollectionType.featured
          ? featuredProductsProvider
          : collectionType == CollectionType.newArrivals
              ? newArrivalsProvider
              : bestSellersProvider,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(collectionType.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(
            collectionType == CollectionType.featured
                ? featuredProductsProvider
                : collectionType == CollectionType.newArrivals
                    ? newArrivalsProvider
                    : bestSellersProvider,
          );
        },
        child: productsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => ErrorView(error: e.toString()),
          data: (products) {
            if (products.isEmpty) {
              return const Center(child: Text('No products found'));
            }
            return GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: products.length,
              itemBuilder: (ctx, i) {
                final product = products[i];
                return ProductCard(
                  product: product,
                  onTap: () => context.push('/product/${product.id}'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}