// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../../../../core/constants/api_endpoints.dart';
// import '../../../../data/models/flash_sale.dart';

// class FlashSaleProductCard extends StatelessWidget {
//   final FlashSaleProduct item;

//   const FlashSaleProductCard({super.key, required this.item});

//   @override
//   Widget build(BuildContext context) {
//     final product = item.product;
//     String? imageUrl;
//     if (product.images != null && product.images!.isNotEmpty) {
//       final primary = product.images!.firstWhere(
//         (img) => img.isPrimary == true,
//         orElse: () => product.images!.first,
//       );
//       imageUrl = primary.imageUrl;
//     }

//     return GestureDetector(
//       onTap: () => context.push('/product/${product.id}'),
//       child: Card(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: 150,
//               width: double.infinity,
//               child: imageUrl != null
//                   ? Image.network(
//                       '${ApiEndpoints.baseUrl}/uploads/profiles/$imageUrl',
//                       fit: BoxFit.cover,
//                     )
//                   : const Center(child: Icon(Icons.image)),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.name,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   Text(
//                     '\$${item.discountPrice.toStringAsFixed(2)}',
//                     style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
//                   ),
//                   if (product.price != null)
//                     Text(
//                       '\$${product.price.toStringAsFixed(2)}',
//                       style: const TextStyle(
//                         decoration: TextDecoration.lineThrough,
//                         fontSize: 12,
//                         color: Colors.grey,
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// lib/presentation/home/widgets/flash_sale_product_card.dart
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

    // Calculate discount percentage if original price exists
    final originalPrice = product.price;
    final discountPrice = item.discountPrice;
    int? discountPercent;
    if (originalPrice != null && originalPrice > 0 && discountPrice > 0) {
      discountPercent = ((originalPrice - discountPrice) / originalPrice * 100).round();
    }

    return GestureDetector(
      onTap: () => context.push('/product/${product.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with discount badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Container(
                    height: 130,
                    width: double.infinity,
                    color: Colors.grey[100],
                    child: imageUrl != null
                        ? Image.network(
                            '${ApiEndpoints.baseUrl}/uploads/profiles/$imageUrl',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(Icons.image, size: 40),
                          )
                        : const Center(child: Icon(Icons.image, size: 40)),
                  ),
                ),
                if (discountPercent != null && discountPercent > 0)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '-$discountPercent%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '\$${discountPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 6),
                      if (originalPrice != null && originalPrice > discountPrice)
                        Text(
                          '\$${originalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                    ],
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