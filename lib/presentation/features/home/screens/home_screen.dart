import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/category_providers.dart';
import '../../../../providers/product_providers.dart';
import '../../../common_widgets/error_view.dart';
import '../../../common_widgets/loading_indicator.dart';
import '../widgets/featured_products.dart';
import '../widgets/new_arrivals.dart';
import '../widgets/best_sellers.dart';
import '../widgets/category_grid.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featuredAsync = ref.watch(featuredProductsProvider);
    final newAsync = ref.watch(newArrivalsProvider);
    final bestAsync = ref.watch(bestSellersProvider);
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
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
            categoriesAsync.when(
              loading: () => const SizedBox(height: 100, child: LoadingIndicator()),
              error: (e, _) => ErrorView(error: e.toString()),
              data: (cats) => CategoryGrid(categories: cats),
            ),
            const SizedBox(height: 24),
            featuredAsync.when(
              loading: () => const SizedBox(height: 200, child: LoadingIndicator()),
              error: (e, _) => ErrorView(error: e.toString()),
              data: (products) => FeaturedProducts(products: products),
            ),
            const SizedBox(height: 24),
            newAsync.when(
              loading: () => const SizedBox(height: 200, child: LoadingIndicator()),
              error: (e, _) => ErrorView(error: e.toString()),
              data: (products) => NewArrivals(products: products),
            ),
            const SizedBox(height: 24),
            bestAsync.when(
              loading: () => const SizedBox(height: 200, child: LoadingIndicator()),
              error: (e, _) => ErrorView(error: e.toString()),
              data: (products) => BestSellers(products: products),
            ),
          ],
        ),
      ),
    );
  }
}