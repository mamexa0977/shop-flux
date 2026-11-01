import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/order.dart';
import '../../../../data/models/seller_order_group.dart';
import '../../../../providers/seller_order_providers.dart';

class SellerOrderDetailScreen extends ConsumerStatefulWidget {
  final SellerOrderGroup group;
  const SellerOrderDetailScreen({super.key, required this.group});

  @override
  ConsumerState<SellerOrderDetailScreen> createState() =>
      _SellerOrderDetailScreenState();
}

class _SellerOrderDetailScreenState
    extends ConsumerState<SellerOrderDetailScreen> {
  late SellerOrderGroup _group;
  final Map<int, bool> _updating = {};

  @override
  void initState() {
    super.initState();
    _group = widget.group;
  }

  Future<void> _updateItemStatus(OrderItem item, String newStatus) async {
    setState(() => _updating[item.id] = true);
    final notifier = ref.read(sellerOrderActionProvider.notifier);
    final success = await notifier.updateOrderItemStatus(item.id, newStatus);
    if (success && mounted) {
      // Update local state by creating a new list
      setState(() {
        final index = _group.items.indexWhere((i) => i.id == item.id);
        if (index != -1) {
          final updatedItem = _group.items[index].copyWith(
            itemStatus: newStatus,
          );
          // Create a new list with the updated item
          final newItems = List<OrderItem>.from(_group.items);
          newItems[index] = updatedItem;
          // Create a new SellerOrderGroup with the updated items list
          _group = SellerOrderGroup(order: _group.order, items: newItems);
        }
        _updating[item.id] = false;
      });
    } else {
      setState(() => _updating[item.id] = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update status')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final order = _group.order;
    final items = _group.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${order.orderNumber}'),
        backgroundColor: const Color(0xFFFFFAD3),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status: ${order.status.toUpperCase()}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    Text('Order Date: ${_formatDate(order.createdAt)}'),
                    Text('Payment Method: ${order.paymentMethod}'),
                    Text('Payment Status: ${order.paymentStatus}'),
                    const SizedBox(height: 8),
                    const Text(
                      'Shipping Address:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(order.shippingAddress ?? 'N/A'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Products',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (ctx, idx) {
                final item = items[idx];
                final currentStatus = item.itemStatus ?? 'pending';
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.product?.name ?? 'Product',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text('x${item.quantity}'),
                          ],
                        ),
                        if (item.variant != null)
                          Text(
                            'Variant: ${item.variant?.attributes.toString() ?? ''}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        Text('Price: ETB ${item.price}'),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              'Item Status: ',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            DropdownButton<String>(
                              value: currentStatus,
                              items:
                                  [
                                        'pending',
                                        'confirmed',
                                        'shipped',
                                        'delivered',
                                        'cancelled',
                                      ]
                                      .map(
                                        (s) => DropdownMenuItem(
                                          value: s,
                                          child: Text(s.toUpperCase()),
                                        ),
                                      )
                                      .toList(),
                              onChanged:
                                  _updating[item.id] == true
                                      ? null
                                      : (newStatus) {
                                        if (newStatus != null)
                                          _updateItemStatus(item, newStatus);
                                      },
                            ),
                            if (_updating[item.id] == true)
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }
}
