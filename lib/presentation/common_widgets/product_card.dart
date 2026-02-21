import 'package:flutter/material.dart';
import '../../data/models/product.dart';
import '../../core/constants/api_endpoints.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    String? imageUrl;
    if (product.images != null && product.images!.isNotEmpty) {
      final primary = product.images!.firstWhere(
        (img) => img.isPrimary == true,
        orElse: () => product.images!.first,
      );
      imageUrl = primary.imageUrl;
    }

    final displayPrice = product.discountPrice ?? product.price;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔁 REPLACED Expanded WITH FIXED HEIGHT CONTAINER
            Container(
              height: 150, // adjust as needed
              width: double.infinity,
              child:
                  imageUrl != null
                      ? Image.network(
                        '${ApiEndpoints.baseUrl}/uploads/profiles/$imageUrl',
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stack) =>
                                const Center(child: Icon(Icons.broken_image)),
                      )
                      : const Center(child: Icon(Icons.image)),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '\$$displayPrice',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
