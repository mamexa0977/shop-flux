import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/category_providers.dart';
import '../../../../providers/product_providers.dart';
import '../../../common_widgets/error_view.dart';
import '../../../common_widgets/loading_indicator.dart';
import '../shimmer/category_grid_shimmer.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/featured_products.dart';
import '../widgets/flash_sale_section.dart';
import '../widgets/new_arrivals.dart';
import '../widgets/best_sellers.dart';
import '../widgets/category_grid.dart';
import 'package:ecom_frontend/providers/auth_state_provider.dart';

import '../widgets/product_horizontal_list_shimmer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featuredAsync = ref.watch(featuredProductsProvider);
    final newAsync = ref.watch(newArrivalsProvider);
    final bestAsync = ref.watch(bestSellersProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final user = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Hello, ${user?.name ?? 'Guest user'}'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(featuredProductsProvider);
          ref.invalidate(newArrivalsProvider);
          ref.invalidate(bestSellersProvider);
          ref.invalidate(categoriesProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            BannerCarousel(), // at the top
            SizedBox(height: 16),
            // ... existing categories, featured, etc.
            const FlashSaleSection(), // after categories
            // const SizedBox(height: 16),
            categoriesAsync.when(
              loading :
                  () => const CategoryGridShimmer(),
              error: (e, _) => ErrorView(error: e.toString()),
              data: (cats) => CategoryGrid(categories: cats),
            ),
            const SizedBox(height: 24),
            featuredAsync.when(
              loading:
                  () => const ProductHorizontalListShimmer(
                    title: 'Featured Products',
                  ),
              error: (e, _) => ErrorView(error: e.toString()),
              data: (products) => FeaturedProducts(products: products),
            ),
            const SizedBox(height: 24),
            newAsync.when(
              loading:
                  () => const ProductHorizontalListShimmer(title: 'New Arrivals'),
              error: (e, _) => ErrorView(error: e.toString()),
              data: (products) => NewArrivals(products: products),
            ),
            const SizedBox(height: 24),
            bestAsync.when(
              loading:
                  () => const ProductHorizontalListShimmer(title: 'Best Sellers'),
              error: (e, _) => ErrorView(error: e.toString()),
              data: (products) => BestSellers(products: products),
            ),
          ],
        ),
      ),
    );
  }
}
