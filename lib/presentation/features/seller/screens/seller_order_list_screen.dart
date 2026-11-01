import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../data/models/seller_order_group.dart';
import '../../../../providers/seller_order_providers.dart';
import '../../../../data/models/order.dart';
import '../../../common_widgets/error_view.dart';
class SellerOrderListScreen extends ConsumerWidget {
  const SellerOrderListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(sellerOrdersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        backgroundColor: const Color(0xFFFFFAD3),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(sellerOrdersProvider),
          ),
        ],
      ),
      body: ordersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: ErrorView(error: error.toString())),
        data: (groups) {
          if (groups.isEmpty) return const Center(child: Text('No orders yet'));
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: groups.length,
            itemBuilder: (context, index) => _OrderCard(group: groups[index]),
          );
        },
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final SellerOrderGroup group;
  const _OrderCard({required this.group});

  @override
  Widget build(BuildContext context) {
    final order = group.order;
    final items = group.items;
    final totalItems = items.fold<int>(0, (sum, item) => sum + item.quantity);
    final totalAmount = items.fold<double>(0, (sum, item) => sum + (item.price * item.quantity));

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.push('/seller/orders/${order.id}', extra: group),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order #${order.orderNumber}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(order.status).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(order.status.toUpperCase(), style: TextStyle(color: _getStatusColor(order.status))),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('Placed: ${_formatDate(order.createdAt)}'),
              Text('Items: $totalItems | Total: ETB ${totalAmount.toStringAsFixed(2)}'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: items.take(3).map((item) => Chip(
                  label: Text(item.product?.name ?? 'Product'),
                  avatar: const Icon(Icons.shopping_bag, size: 16),
                )).toList(),
              ),
              if (items.length > 3) Text('+ ${items.length - 3} more', style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) => switch (status) {
    'pending' => Colors.orange,
    'confirmed' => Colors.blue,
    'processing' => Colors.purple,
    'shipped' => Colors.cyan,
    'delivered' => Colors.green,
    'cancelled' => Colors.red,
    _ => Colors.grey,
  };

  String _formatDate(DateTime? date) => date == null ? '' : '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
}