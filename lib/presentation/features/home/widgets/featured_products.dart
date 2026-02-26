import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../data/models/product.dart';
import 'product_horizontal_list.dart';

class FeaturedProducts extends StatelessWidget {
  final List<Product> products;

  const FeaturedProducts({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ProductHorizontalList(
      title: 'Featured Products',
      products: products,
      onViewAll: () {
        context.push('/collection/featured');
        // Navigate to full list (to be implemented later)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('View all featured products')),
        );
      },
    );
  }
}