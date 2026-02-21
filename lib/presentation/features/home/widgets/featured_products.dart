import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // ← add this
import '../../../../data/models/product.dart';
import '../../../common_widgets/product_card.dart';

class FeaturedProducts extends StatelessWidget {
  final List<Product> products;

  const FeaturedProducts({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Featured Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: products.length,
            itemBuilder: (ctx, i) {
              final product = products[i];
              return SizedBox(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: ProductCard(
                    product: product,
                    onTap: () => context.push('/product/${product.id}'), // ← changed
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}