import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../providers/product_providers.dart';
import '../../../common_widgets/error_view.dart';
import '../../../common_widgets/loading_indicator.dart';
import '../../../common_widgets/product_card.dart';
import '../widgets/filter_bottom_sheet.dart';

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
      // Use the notifier specific to this category
      ref
          .read(productListProvider(widget.categorySlug).notifier)
          .loadNextPage();
    }
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (_) => FilterBottomSheet(
            currentFilters: {},
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
    // Watch the family provider with the category slug
    final productsAsync = ref.watch(productListProvider(widget.categorySlug));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categorySlug ?? 'Products'),
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
          loading: () => const LoadingIndicator(),
          error: (e, _) => ErrorView(error: e.toString()),
          data: (products) {
            if (products.isEmpty) {
              return const Center(child: Text('No products found'));
            }
            return ListView.builder(
              controller: _scrollController,
              itemCount: products.length, // removed extra loading item
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
