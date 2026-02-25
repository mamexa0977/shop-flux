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
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fixed square image
            AspectRatio(
              aspectRatio: 1,
              child:
                  imageUrl != null
                      ? Image.network(
                        // ⚠️ Verify path – should probably be '/uploads/products/'
                        '${ApiEndpoints.baseUrl}/uploads/profiles/$imageUrl',
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stack) =>
                                const Center(child: Icon(Icons.broken_image)),
                      )
                      : const Center(child: Icon(Icons.image)),
            ),
            // Flexible text area that fills remaining grid cell height
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$$displayPrice',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF015733), // Your brand color
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
