import 'package:flutter/material.dart';
import '../../../../core/utils/image_utils.dart';
import '../../../../data/models/product.dart';

class ProductCardSeller extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onUpdateStock;

  const ProductCardSeller({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
    required this.onUpdateStock,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = product.images?.isNotEmpty == true
        ? ImageUtils.getFullImageUrl(product.images!.first.imageUrl)
        : null;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imageUrl != null
                  ? Image.network(
                      imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 80),
                    )
                  : Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, size: 40),
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text('Price: ETB ${product.price}'),
                  Text('Stock: ${product.stock ?? 0}',
                      style: TextStyle(
                        color: (product.stock ?? 0) < 5 ? Colors.red : Colors.green,
                        fontWeight: FontWeight.w500,
                      )),
                  if (product.discountPrice != null)
                    Text('Discount: ETB ${product.discountPrice}',
                        style: const TextStyle(color: Colors.orange)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      _actionChip(Icons.edit, 'Edit', onEdit),
                      _actionChip(Icons.delete_outline, 'Delete', onDelete, color: Colors.red),
                      _actionChip(Icons.inventory, 'Stock', onUpdateStock, color: Colors.blue),
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

  Widget _actionChip(IconData icon, String label, VoidCallback onTap, {Color color = Colors.grey}) {
    return ActionChip(
      avatar: Icon(icon, size: 16, color: color),
      label: Text(label),
      onPressed: onTap,
      backgroundColor: color.withOpacity(0.1),
    );
  }
}