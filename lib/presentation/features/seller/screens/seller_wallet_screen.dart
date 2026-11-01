import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../providers/seller_wallet_providers.dart';
import '../../../common_widgets/error_view.dart';

class SellerWalletScreen extends ConsumerWidget {
  const SellerWalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletAsync = ref.watch(sellerWalletProvider);
    final historyAsync = ref.watch(sellerWithdrawalHistoryProvider);
    double _parseBalance(dynamic value) {
      if (value == null) return 0.0;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        backgroundColor: const Color(0xFFFFFAD3),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(sellerWalletProvider);
              ref.invalidate(sellerWithdrawalHistoryProvider);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(sellerWalletProvider);
          ref.invalidate(sellerWithdrawalHistoryProvider);
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Wallet balance card
              walletAsync.when(
                // Display
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => ErrorView(error: error.toString()),
                data: (wallet) {
                  final currentBalance = _parseBalance(
                    wallet['currentBalance'],
                  );
                  final pendingBalance = _parseBalance(
                    wallet['pendingBalance'],
                  );
                  final lifetimeEarnings = _parseBalance(
                    wallet['lifetimeEarnings'],
                  );
                  final totalWithdrawn = _parseBalance(
                    wallet['totalWithdrawn'],
                  );
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Text(
                            'Current Balance',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'ETB ${currentBalance.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _InfoChip(
                                label: 'Pending',
                                value:
                                    'ETB ${pendingBalance.toStringAsFixed(2)}',
                                color: Colors.orange,
                              ),
                              _InfoChip(
                                label: 'Lifetime',
                                value:
                                    'ETB ${lifetimeEarnings.toStringAsFixed(2)}',
                                color: Colors.blue,
                              ),
                              _InfoChip(
                                label: 'Withdrawn',
                                value:
                                    'ETB ${totalWithdrawn.toStringAsFixed(2)}',
                                color: Colors.purple,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed:
                                () => context.push('/seller/wallet/withdraw'),
                            icon: const Icon(Icons.request_page),
                            label: const Text('Request Withdrawal'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 44),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Withdrawal History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              historyAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => ErrorView(error: error.toString()),
                data: (history) {
                  if (history.isEmpty) {
                    return const Center(child: Text('No withdrawals yet'));
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: history.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (ctx, idx) {
                      final w = history[idx];
                      return ListTile(
                        title: Text(
                          'ETB ${(w['amount'] ?? 0).toStringAsFixed(2)}',
                        ),
                        subtitle: Text('Method: ${w['method']}'),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(
                              w['status'],
                            ).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            w['status'] ?? 'pending',
                            style: TextStyle(
                              color: _getStatusColor(w['status']),
                            ),
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
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _InfoChip({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
