// lib/presentation/flash_sale/flash_sale_products_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/models/flash_sale.dart';
import 'flash_sale_product_card.dart';
import 'countdown_timer.dart';
import 'flash_sale_product_card.dart';

class FlashSaleProductsScreen extends StatelessWidget {
  final FlashSale flashSale;

  const FlashSaleProductsScreen({super.key, required this.flashSale});

  @override
  Widget build(BuildContext context) {
    final products = flashSale.products;

    return Scaffold(
      appBar: AppBar(
        title: Text(flashSale.name),
        actions: [
          // Optional: share button or something
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share flash sale link
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              border: Border(
                top: BorderSide(color: Colors.red.shade200),
                bottom: BorderSide(color: Colors.red.shade200),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Ends in:',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                CountdownTimer(
                  endTime: flashSale.endTime,
                  onFinished: () {
                    // Optionally pop or refresh when timer ends
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Flash sale ended')),
                    );
                    context.pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: products.isEmpty
          ? const Center(child: Text('No products in this flash sale'))
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: products.length,
              itemBuilder: (ctx, i) {
                final item = products[i];
                return FlashSaleProductCard(item: item);
              },
            ),
    );
  }
}