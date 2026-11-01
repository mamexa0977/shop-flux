import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../data/models/order.dart';
import '../../../../providers/order_providers.dart';
import '../../../common_widgets/error_view.dart';
import '../../../common_widgets/custom_button.dart';

class OrderDetailScreen extends ConsumerStatefulWidget {
  final int orderId;
  const OrderDetailScreen({super.key, required this.orderId});

  @override
  ConsumerState<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends ConsumerState<OrderDetailScreen> {
  bool _isCancelling = false;
  bool _isReturning = false;
  final Set<int> _selectedReturnItemIds = {};

  Future<void> _cancelOrder(Order order) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel Order'),
        content: const Text('Are you sure you want to cancel this order?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('No')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Yes')),
        ],
      ),
    );
    if (confirm != true) return;

    setState(() => _isCancelling = true);
    final notifier = ref.read(orderActionProvider.notifier);
    final success = await notifier.cancelOrder(order.id);
    setState(() => _isCancelling = false);
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order cancelled')));
      ref.invalidate(orderDetailsProvider(widget.orderId));
    }
  }

  Future<void> _requestReturn(Order order) async {
    if (_selectedReturnItemIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one item to return')),
      );
      return;
    }

    final reasonController = TextEditingController();
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Request Return'),
        content: TextField(
          controller: reasonController,
          decoration: const InputDecoration(labelText: 'Reason for return'),
          maxLines: 3,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, reasonController.text.isNotEmpty),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
    if (result != true || reasonController.text.isEmpty) return;

    setState(() => _isReturning = true);
    final notifier = ref.read(orderActionProvider.notifier);
    final success = await notifier.requestReturn(
      order.id,
      reasonController.text,
      _selectedReturnItemIds.toList(),
    );
    setState(() => _isReturning = false);
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Return request submitted')));
      ref.invalidate(orderDetailsProvider(widget.orderId));
      _selectedReturnItemIds.clear();
    }
  }

  Future<void> _downloadInvoice(Order order) async {
    final notifier = ref.read(orderActionProvider.notifier);
    final url = await notifier.getInvoiceUrl(order.id);
    if (url != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invoice URL: $url')));
    }
  }

  String _formatShippingAddress(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) return 'N/A';
    try {
      final Map<String, dynamic> address = jsonDecode(jsonString);
      final parts = <String>[];
      if (address['addressLine1'] != null) parts.add(address['addressLine1']);
      if (address['addressLine2'] != null && address['addressLine2'].toString().isNotEmpty) parts.add(address['addressLine2']);
      if (address['city'] != null) parts.add(address['city']);
      if (address['state'] != null && address['state'].toString().isNotEmpty) parts.add(address['state']);
      if (address['postalCode'] != null) parts.add(address['postalCode']);
      if (address['country'] != null) parts.add(address['country']);
      return parts.join(', ');
    } catch (e) {
      return jsonString;
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderAsync = ref.watch(orderDetailsProvider(widget.orderId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: const Color(0xFFFFFAD3),
      ),
      body: orderAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: ErrorView(error: error.toString())),
        data: (order) {
          final items = order.items ?? [];
          final canCancel = order.status == 'pending';
          final canReturn = order.status == 'delivered';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
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
                        const Divider(),
                        Text('Placed on: ${_formatDate(order.createdAt)}'),
                        Text('Payment Method: ${order.paymentMethod}'),
                        Text('Payment Status: ${order.paymentStatus}'),
                        const SizedBox(height: 8),
                        const Text('Shipping Address:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(_formatShippingAddress(order.shippingAddress)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    if (canReturn)
                      TextButton.icon(
                        onPressed: () => _requestReturn(order),
                        icon: _isReturning
                            ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                            : const Icon(Icons.assignment_return),
                        label: const Text('Return Selected'),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (ctx, idx) {
                    final item = items[idx];
                    final itemStatus = item.itemStatus ?? 'pending';
                    final isSelected = _selectedReturnItemIds.contains(item.id);
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (canReturn)
                              Checkbox(
                                value: isSelected,
                                onChanged: (checked) {
                                  setState(() {
                                    if (checked == true) {
                                      _selectedReturnItemIds.add(item.id);
                                    } else {
                                      _selectedReturnItemIds.remove(item.id);
                                    }
                                  });
                                },
                              ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item.product?.name ?? 'Product',
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: _getItemStatusColor(itemStatus).withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          itemStatus.toUpperCase(),
                                          style: TextStyle(color: _getItemStatusColor(itemStatus), fontSize: 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  if (item.variant != null)
                                    Text('Variant: ${item.variant!.attributes.toString()}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Qty: ${item.quantity} x ETB ${item.price}'),
                                      Text('ETB ${(item.price * item.quantity).toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Amount:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('ETB ${order.totalAmount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    if (canCancel)
                      Expanded(
                        child: CustomButton(
                          text: 'Cancel Order',
                          onPressed: () => _cancelOrder(order),
                          isLoading: _isCancelling,
                          backgroundColor: Colors.red,
                        ),
                      ),
                    if (canCancel && canReturn) const SizedBox(width: 12),
                    if (canReturn)
                      Expanded(
                        child: CustomButton(
                          text: 'Return Selected Items',
                          onPressed: () => _requestReturn(order),
                          isLoading: _isReturning,
                          backgroundColor: Colors.orange,
                        ),
                      ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _downloadInvoice(order),
                        icon: const Icon(Icons.receipt),
                        label: const Text('Invoice'),
                        style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending': return Colors.orange;
      case 'confirmed': return Colors.blue;
      case 'processing': return Colors.purple;
      case 'shipped': return Colors.cyan;
      case 'delivered': return Colors.green;
      case 'cancelled': return Colors.red;
      default: return Colors.grey;
    }
  }

  Color _getItemStatusColor(String status) {
    switch (status) {
      case 'pending': return Colors.orange;
      case 'confirmed': return Colors.blue;
      case 'shipped': return Colors.cyan;
      case 'delivered': return Colors.green;
      case 'cancelled': return Colors.red;
      default: return Colors.grey;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }
}