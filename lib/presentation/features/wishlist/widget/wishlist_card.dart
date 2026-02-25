import 'package:flutter/material.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../data/models/product.dart';
import '../../../../data/models/wishlist.dart';

class WishlistCard extends StatelessWidget {
  final WishlistProduct? product; // product might be null if relation fails

  const WishlistCard({required this.product});

  @override
  Widget build(BuildContext context) {
    // Safely extract data with fallbacks
    final name = product?.name ?? 'Unknown Product';
    final price = product?.price ?? 0.0;
    final discountPrice = product?.discountPrice;
    final hasDiscount = discountPrice != null && discountPrice < price;
    final displayPrice = hasDiscount ? discountPrice : price;
    final originalPrice = hasDiscount ? price : null;

    // Get image URL
    String? imageUrl;
    if (product?.ProductImages != null && product!.ProductImages!.isNotEmpty) {
      imageUrl = '${ApiEndpoints.baseUrl}/uploads/products/${product!.ProductImages!.first.imageUrl}';
    }

    // Dummy rating (replace with real rating later)
    final dummyRating = 4.5; // between 0-5

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image (square, fixed size)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.grey[200],
                child: imageUrl != null
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stack) => const Icon(Icons.broken_image),
                      )
                    : const Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
              ),
            ),
            const SizedBox(width: 16),

            // Product details (expanded to fill remaining space)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product name
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Rating row (dummy)
                  Row(
                    children: [
                      ...List.generate(5, (i) {
                        return Icon(
                          i < dummyRating.floor() ? Icons.star : Icons.star_border,
                          size: 16,
                          color: Colors.amber,
                        );
                      }),
                      const SizedBox(width: 4),
                      Text(
                        '(${dummyRating.toStringAsFixed(1)})',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Price row
                  Row(
                    children: [
                      Text(
                        '\$${displayPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      if (originalPrice != null) ...[
                        const SizedBox(width: 8),
                        Text(
                          '\$${originalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Action buttons (column)
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remove from wishlist (heart icon)
                IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () {
                    // TODO: Implement remove from wishlist
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Remove from wishlist (not implemented yet)')),
                    );
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(height: 8),
                // Add to cart button
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement add to cart
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to cart (not implemented yet)')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(40, 40),
                    padding: EdgeInsets.zero,
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(Icons.add_shopping_cart, size: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}