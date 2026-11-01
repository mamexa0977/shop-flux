import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../providers/seller_promotion_providers.dart';
import '../../../common_widgets/error_view.dart';

class SellerFlashSaleListScreen extends ConsumerWidget {
  const SellerFlashSaleListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flashSalesAsync = ref.watch(sellerAvailableFlashSalesProvider);
    final submissionsAsync = ref.watch(sellerFlashSaleSubmissionsProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flash Sales'),
          backgroundColor: const Color(0xFFFFFAD3),
          bottom: const TabBar(tabs: [
            Tab(text: 'Available'),
            Tab(text: 'My Submissions'),
          ]),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                ref.invalidate(sellerAvailableFlashSalesProvider);
                ref.invalidate(sellerFlashSaleSubmissionsProvider);
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            // Available tab
            flashSalesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: ErrorView(error: error.toString())),
              data: (sales) {
                if (sales.isEmpty) return const Center(child: Text('No active flash sales'));
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: sales.length,
                  itemBuilder: (ctx, idx) {
                    final sale = sales[idx];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        title: Text(sale['name']),
                        subtitle: Text('${_formatDate(sale['startTime'])} → ${_formatDate(sale['endTime'])}'),
                        trailing: ElevatedButton(
                          onPressed: () => context.push('/seller/flash-sales/${sale['id']}/participate', extra: sale),
                          child: const Text('Participate'),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            // Submissions tab
            submissionsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: ErrorView(error: error.toString())),
              data: (subs) {
                if (subs.isEmpty) return const Center(child: Text('No submissions yet'));
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: subs.length,
                  itemBuilder: (ctx, idx) {
                    final s = subs[idx];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        title: Text(s['Product']?['name'] ?? 'Product'),
                        subtitle: Text('Discount Price: ETB ${s['discountPrice']}'),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: (s['approved'] == true ? Colors.green : Colors.orange).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(s['approved'] == true ? 'Approved' : 'Pending', style: TextStyle(color: s['approved'] == true ? Colors.green : Colors.orange)),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String? iso) {
    if (iso == null) return '';
    final date = DateTime.tryParse(iso);
    if (date == null) return '';
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }
}