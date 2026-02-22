import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/flash_sale_providers.dart';
import 'flash_sale_product_card.dart';

class FlashSaleSection extends ConsumerWidget {
  const FlashSaleSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flashSalesAsync = ref.watch(flashSalesProvider);

    return flashSalesAsync.when(
      loading: () => const SizedBox(height: 200, child: Center(child: CircularProgressIndicator())),
      error: (_, __) => const SizedBox.shrink(),
      data: (flashSales) {
        if (flashSales.isEmpty) return const SizedBox.shrink();

        // Show the first active flash sale (or you could show all in separate rows)
        final flashSale = flashSales.first;
        final products = flashSale.products;
        if (products.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                flashSale.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: products.length,
                itemBuilder: (ctx, i) {
                  final item = products[i];
                  return SizedBox(
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: FlashSaleProductCard(item: item),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}