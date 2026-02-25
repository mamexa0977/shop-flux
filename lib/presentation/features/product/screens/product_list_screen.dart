import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart'; // add to pubspec.yaml

import '../../../../providers/product_providers.dart';
import '../../../common_widgets/error_view.dart';
import '../../../common_widgets/product_card.dart';
import '../shimmer/product_card_shimmer.dart';
import '../widgets/filter_bottom_sheet.dart';
 // our custom shimmer

class ProductListScreen extends ConsumerStatefulWidget {
  final String? categorySlug;
  const ProductListScreen({super.key, this.categorySlug});

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref
          .read(productListProvider(widget.categorySlug).notifier)
          .loadNextPage();
    }
  }

  void _showFilterSheet() {
   final currentFilters = ref.read(productListProvider(widget.categorySlug).notifier).currentFilters;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => FilterBottomSheet(
        currentFilters: currentFilters,
        onApply: (filters) {
          ref
              .read(productListProvider(widget.categorySlug).notifier)
              .applyFilters(filters);
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productListProvider(widget.categorySlug));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categorySlug?.replaceAll('-', ' ').toUpperCase() ?? 'Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterSheet,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(productListProvider(widget.categorySlug).notifier).refresh();
        },
        child: productsAsync.when(
          loading: () => _buildShimmerGrid(),
          error: (e, _) => ErrorView(error: e.toString()),
          data: (products) {
            if (products.isEmpty) {
              return const Center(child: Text('No products found'));
            }
            return GridView.builder(
              controller: _scrollController,
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

  Widget _buildShimmerGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 6, // show 6 shimmer cards
      itemBuilder: (ctx, i) => const ProductCardShimmer(),
    );
  }
}