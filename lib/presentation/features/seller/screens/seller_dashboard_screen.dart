import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../providers/seller_dashboard_providers.dart';
import '../widgets/seller_stats_card.dart';
import '../../../common_widgets/error_view.dart';

class SellerDashboardScreen extends ConsumerStatefulWidget {
  const SellerDashboardScreen({super.key});

  @override
  ConsumerState<SellerDashboardScreen> createState() => _SellerDashboardScreenState();
}

class _SellerDashboardScreenState extends ConsumerState<SellerDashboardScreen> {
  Future<void> _refreshDashboard(WidgetRef ref) async {
    ref.invalidate(sellerDashboardProvider);
    await ref.read(sellerDashboardProvider.future);
  }

  @override
  Widget build(BuildContext context) {
    final dashboardAsync = ref.watch(sellerDashboardProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Dashboard'),
        backgroundColor: const Color(0xFFFFFAD3),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _refreshDashboard(ref),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshDashboard(ref),
        child: dashboardAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: ErrorView(
              error: error.toString(),
              onRetry: () => _refreshDashboard(ref),
            ),
          ),
          data: (data) {
            final totalProducts = data['totalProducts'] ?? 0;
            final totalOrders = data['totalOrders'] ?? 0;
            final revenue = (data['revenue'] ?? 0.0).toDouble();
            final pendingOrders = data['pendingOrders'] ?? 0;
            final wallet = data['wallet'] ?? {};
            final currentBalance = (wallet['currentBalance'] ?? 0.0).toDouble();

            final salesGraph = data['salesGraph'] as List? ?? [];
            
            // Calculate max sales safely (avoid division by zero)
            double maxSales = 1.0;
            if (salesGraph.isNotEmpty) {
              final salesValues = salesGraph
                  .map((e) => (e['sales'] as num?)?.toDouble() ?? 0.0)
                  .toList();
              maxSales = salesValues.isNotEmpty ? salesValues.reduce((a, b) => a > b ? a : b) : 1.0;
              if (maxSales <= 0) maxSales = 1.0;
            }

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.5,
                    children: [
                      SellerStatsCard(
                        title: 'Total Products',
                        value: totalProducts.toString(),
                        icon: Icons.inventory,
                        color: Colors.green,
                      ),
                      SellerStatsCard(
                        title: 'Total Orders',
                        value: totalOrders.toString(),
                        icon: Icons.shopping_bag,
                        color: Colors.orange,
                      ),
                      SellerStatsCard(
                        title: 'Revenue',
                        value: 'ETB ${revenue.toStringAsFixed(2)}',
                        icon: Icons.attach_money,
                        color: Colors.blue,
                      ),
                      SellerStatsCard(
                        title: 'Pending Orders',
                        value: pendingOrders.toString(),
                        icon: Icons.pending_actions,
                        color: Colors.red,
                      ),
                      SellerStatsCard(
                        title: 'Wallet Balance',
                        value: 'ETB ${currentBalance.toStringAsFixed(2)}',
                        icon: Icons.account_balance_wallet,
                        color: Colors.purple,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Sales graph section
                  const Text(
                    'Sales (Last 7 Days)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: salesGraph.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(24.0),
                              child: Text(
                                'No sales data available for the last 7 days',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        : Column(
                            children: salesGraph.map<Widget>((day) {
                              final sales = (day['sales'] as num?)?.toDouble() ?? 0.0;
                              // Safe percentage: clamp between 0 and 1
                              double percentage = (sales / maxSales).clamp(0.0, 1.0);
                              if (percentage.isNaN || percentage.isInfinite) percentage = 0.0;

                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          day['date'] ?? 'Unknown date',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          'ETB ${sales.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: LinearProgressIndicator(
                                        value: percentage,
                                        backgroundColor: Colors.grey[200],
                                        color: Colors.green,
                                        minHeight: 8,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                  ),

                  const SizedBox(height: 24),

                  // Quick action buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => context.push('/seller/products'),
                          icon: const Icon(Icons.add_shopping_cart),
                          label: const Text('Manage Products'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => context.push('/seller/orders'),
                          icon: const Icon(Icons.list_alt),
                          label: const Text('View Orders'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}