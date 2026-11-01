import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/seller_order_providers.dart';
import '../../../../data/models/return_request.dart';
import '../../../common_widgets/error_view.dart';

class SellerReturnListScreen extends ConsumerWidget {
  const SellerReturnListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final returnsAsync = ref.watch(sellerReturnsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Return Requests'),
        backgroundColor: const Color(0xFFFFFAD3),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(sellerReturnsProvider),
          ),
        ],
      ),
      body: returnsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: ErrorView(error: error.toString())),
        data: (returns) {
          if (returns.isEmpty) {
            return const Center(child: Text('No return requests'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: returns.length,
            itemBuilder: (context, index) {
              final req = returns[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Order #${req.orderId}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                color: _getStatusColor(req.status ?? '').withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(req.status?.toUpperCase() ?? '', style: TextStyle(color: _getStatusColor(req.status?? ''))),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('Reason: ${req.reason}'),
                      Text('Requested: ${_formatDate(req.createdAt)}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending': return Colors.orange;
      case 'approved': return Colors.green;
      case 'rejected': return Colors.red;
      case 'completed': return Colors.blue;
      default: return Colors.grey;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day}/${date.month}/${date.year}';
  }
}