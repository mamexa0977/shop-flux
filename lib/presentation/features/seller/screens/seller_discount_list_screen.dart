import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../providers/seller_promotion_providers.dart';
import '../../../common_widgets/error_view.dart';

class SellerDiscountListScreen extends ConsumerWidget {
  const SellerDiscountListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final discountsAsync = ref.watch(sellerDiscountsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discounts'),
        backgroundColor: const Color(0xFFFFFAD3),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(sellerDiscountsProvider),
          ),
        ],
      ),
      body: discountsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: ErrorView(error: error.toString())),
        data: (discounts) {
          if (discounts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No discounts created yet'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.push('/seller/discounts/add'),
                    child: const Text('Create Discount'),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: discounts.length,
            itemBuilder: (ctx, idx) {
              final d = discounts[idx];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(d['name']),
                  subtitle: Text('${d['type'] == 'percentage' ? d['value'].toString() + '%' : 'ETB ' + d['value'].toString()} off'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => context.push('/seller/discounts/${d['id']}/edit', extra: d),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteDiscount(ref, d['id']),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/seller/discounts/add'),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _deleteDiscount(WidgetRef ref, int id) async {
    final notifier = ref.read(sellerPromotionActionProvider.notifier);
    await notifier.deleteDiscount(id);
  }
}