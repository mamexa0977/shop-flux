import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../providers/seller_promotion_providers.dart';
import '../../../../providers/seller_product_providers.dart';

class SellerFlashSaleParticipateScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> flashSale;
  const SellerFlashSaleParticipateScreen({super.key, required this.flashSale});

  @override
  ConsumerState<SellerFlashSaleParticipateScreen> createState() => _SellerFlashSaleParticipateScreenState();
}

class _SellerFlashSaleParticipateScreenState extends ConsumerState<SellerFlashSaleParticipateScreen> {
  int? _selectedProductId;
  final _discountPriceController = TextEditingController();

  @override
  void dispose() {
    _discountPriceController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_selectedProductId == null || _discountPriceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select product and enter discount price')));
      return;
    }
    final data = {
      'productId': _selectedProductId,
      'discountPrice': double.parse(_discountPriceController.text),
    };
    final notifier = ref.read(sellerPromotionActionProvider.notifier);
    await notifier.participateInFlashSale(widget.flashSale['id'], data);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product submitted for approval')));
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(sellerProductListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Participate in ${widget.flashSale['name']}'),
        backgroundColor: const Color(0xFFFFFAD3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            productsAsync.when(
              loading: () => const CircularProgressIndicator(),
              error: (error, _) => Text('Error: $error'),
              data: (products) {
                return DropdownButtonFormField<int>(
                  value: _selectedProductId,
                  decoration: const InputDecoration(labelText: 'Select Product*'),
                  items: products.map((p) => DropdownMenuItem(value: p.id, child: Text(p.name))).toList(),
                  onChanged: (v) => setState(() => _selectedProductId = v),
                );
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _discountPriceController,
              decoration: const InputDecoration(labelText: 'Discount Price (ETB)*'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
              child: const Text('Submit for Approval'),
            ),
          ],
        ),
      ),
    );
  }
}