import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/seller_order_providers.dart';
import '../../../../data/models/product.dart';
import '../../../common_widgets/error_view.dart';

class SellerInventoryScreen extends ConsumerStatefulWidget {
  const SellerInventoryScreen({super.key});

  @override
  ConsumerState<SellerInventoryScreen> createState() => _SellerInventoryScreenState();
}

class _SellerInventoryScreenState extends ConsumerState<SellerInventoryScreen> {
  final Map<int, TextEditingController> _stockControllers = {};

  @override
  void dispose() {
    for (var controller in _stockControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _updateStock(int productId, int newStock) async {
    final notifier = ref.read(sellerOrderActionProvider.notifier);
    await notifier.bulkUpdateStock([{'productId': productId, 'stock': newStock}]);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Stock updated')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final inventoryAsync = ref.watch(sellerInventoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
        backgroundColor: const Color(0xFFFFFAD3),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(sellerInventoryProvider),
          ),
        ],
      ),
      body: inventoryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: ErrorView(error: error.toString())),
        data: (products) {
          if (products.isEmpty) {
            return const Center(child: Text('No products'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final controller = _stockControllers.putIfAbsent(product.id, () => TextEditingController(text: product.stock?.toString() ?? '0'));
              final isLowStock = (product.stock ?? 0) < 5;
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                            if (isLowStock)
                              const Text('Low stock!', style: TextStyle(color: Colors.red, fontSize: 12)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          controller: controller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Stock', border: OutlineInputBorder()),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.save),
                        onPressed: () {
                          final newStock = int.tryParse(controller.text);
                          if (newStock != null && newStock != product.stock) {
                            _updateStock(product.id, newStock);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}