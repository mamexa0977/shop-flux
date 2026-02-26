import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../data/models/product.dart';
import 'product_horizontal_list.dart';

class BestSellers extends StatelessWidget {
  final List<Product> products;

  const BestSellers({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ProductHorizontalList(
      title: 'Best Sellers',
      products: products,
      onViewAll: () {
        context.push('/collection/best-sellers');
        // Navigate to full list (to be implemented later)
      
      },
    );
  }
}
