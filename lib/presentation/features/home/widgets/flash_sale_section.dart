// lib/presentation/home/widgets/flash_sale_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../providers/flash_sale_providers.dart';
import 'flash_sale_product_card.dart';
import 'countdown_timer.dart';
import 'flash_sale_shimmer.dart';

class FlashSaleSection extends ConsumerWidget {
  const FlashSaleSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flashSalesAsync = ref.watch(flashSalesProvider);

    return flashSalesAsync.when(
      loading: () => const FlashSaleShimmer(),
      error: (_, __) => const SizedBox.shrink(), // Silently fail on error
      data: (flashSales) {
        if (flashSales.isEmpty) return const SizedBox.shrink();

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: flashSales.length,
          separatorBuilder: (_, __) => const SizedBox(height: 24),
          itemBuilder: (context, index) {
            final flashSale = flashSales[index];
            final products = flashSale.products;
            if (products.isEmpty) return const SizedBox.shrink();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with name, timer, and "View all"
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          flashSale.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      CountdownTimer(
                        endTime: flashSale.endTime,
                        onFinished: () {
                          // Optionally refresh provider when timer ends
                          ref.invalidate(flashSalesProvider);
                        },
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {
                          context.push(   
                            '/flash-sale/${flashSale.id}',
                            extra: flashSale, // pass the whole object
                          );
                          // Navigate to flash sale detail page (to be implemented)
                          // For now, just show a snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'View all products in ${flashSale.name}',
                              ),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50, 30),
                        ),
                        child: const Text('View all'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 240, // Slightly taller for improved card
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
      },
    );
  }
}
