import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../data/models/flash_sale.dart';

class FlashSaleProductCard extends StatelessWidget {
  final FlashSaleProduct item;

  const FlashSaleProductCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final product = item.product;
    String? imageUrl;
    if (product.images != null && product.images!.isNotEmpty) {
      final primary = product.images!.firstWhere(
        (img) => img.isPrimary == true,
        orElse: () => product.images!.first,
      );
      imageUrl = primary.imageUrl;
    }

    return GestureDetector(
      onTap: () => context.push('/product/${product.id}'),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: double.infinity,
              child: imageUrl != null
                  ? Image.network(
                      '${ApiEndpoints.baseUrl}/uploads/profiles/$imageUrl',
                      fit: BoxFit.cover,
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
                    '\$${item.discountPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  if (product.price != null)
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
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