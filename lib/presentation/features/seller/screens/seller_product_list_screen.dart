import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../providers/seller_product_providers.dart';
import '../../../../data/models/product.dart';
import '../widgets/product_card_seller.dart';
import '../../../common_widgets/error_view.dart';

class SellerProductListScreen extends ConsumerWidget {
  const SellerProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(sellerProductListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
        backgroundColor: const Color(0xFFFFFAD3),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(sellerProductListProvider),
          ),
        ],
      ),
      body: productsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: ErrorView(error: error.toString())),
        data: (products) {
          if (products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.inventory, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('No products yet'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.push('/seller/products/add'),
                    child: const Text('Add Product'),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index]; // ✅ store in local variable
              return ProductCardSeller(
                product: product,
                onEdit: () => context.push(
                  '/seller/products/${product.id}/edit',
                  extra: product,
                ),
                onDelete: () => _showDeleteDialog(context, ref, product.id),
                onUpdateStock: () => _showStockDialog(context, ref, product),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/seller/products/add'),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref, int productId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure? This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final notifier = ref.read(sellerProductActionProvider.notifier);
              await notifier.deleteProduct(productId);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Product deleted')),
                );
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showStockDialog(BuildContext context, WidgetRef ref, Product product) {
    final stockController = TextEditingController(text: product.stock?.toString() ?? '0');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Update Stock: ${product.name}'),
        content: TextField(
          controller: stockController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Stock quantity'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              final newStock = int.tryParse(stockController.text);
              if (newStock != null) {
                Navigator.pop(ctx);
                final notifier = ref.read(sellerProductActionProvider.notifier);
                await notifier.updateStock(product.id, newStock);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Stock updated')),
                  );
                }
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}