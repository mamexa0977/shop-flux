import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../data/models/product.dart';
import 'product_horizontal_list.dart';

class NewArrivals extends StatelessWidget {
  final List<Product> products;

  const NewArrivals({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ProductHorizontalList(
      title: 'New Arrivals',
      products: products,
      onViewAll: () {
        context.push('/collection/new-arrivals');
        // Navigate to full list (to be implemented later)
     
      },
    );
  }
}