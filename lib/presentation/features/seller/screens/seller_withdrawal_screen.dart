import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../providers/seller_wallet_providers.dart';

class SellerWithdrawalScreen extends ConsumerStatefulWidget {
  const SellerWithdrawalScreen({super.key});

  @override
  ConsumerState<SellerWithdrawalScreen> createState() => _SellerWithdrawalScreenState();
}

class _SellerWithdrawalScreenState extends ConsumerState<SellerWithdrawalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  String _method = 'bank'; // 'bank' or 'mobile_money'
  String? _bankName, _bankAccountName, _bankAccountNumber;
  String? _mobileProvider, _mobileNumber;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final data = {
      'amount': double.parse(_amountController.text),
      'method': _method,
    };
    if (_method == 'bank') {
      data['bankName'] = _bankName ?? '';
      data['bankAccountName'] = _bankAccountName ?? '';
      data['bankAccountNumber'] = _bankAccountNumber ?? '';
    } else {
      data['mobileProvider'] = _mobileProvider ?? '';
      data['mobileNumber'] = _mobileNumber ?? '';
    }

    final notifier = ref.read(sellerWalletActionProvider.notifier);
    await notifier.requestWithdrawal(data);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Withdrawal request submitted')));
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Withdrawal'), backgroundColor: const Color(0xFFFFFAD3)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount (ETB)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || double.tryParse(v) == null ? 'Enter valid amount' : null,
              ),
              const SizedBox(height: 16),
              const Text('Withdrawal Method', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Bank'),
                      value: 'bank',
                      groupValue: _method,
                      onChanged: (val) => setState(() => _method = val!),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Mobile Money'),
                      value: 'mobile_money',
                      groupValue: _method,
                      onChanged: (val) => setState(() => _method = val!),
                    ),
                  ),
                ],
              ),
              if (_method == 'bank') ...[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Bank Name'),
                  onChanged: (v) => _bankName = v,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Account Name'),
                  onChanged: (v) => _bankAccountName = v,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Account Number'),
                  onChanged: (v) => _bankAccountNumber = v,
                ),
              ] else ...[
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Provider'),
                  items: ['mtn', 'airtel', 'telecel'].map((p) => DropdownMenuItem(value: p, child: Text(p.toUpperCase()))).toList(),
                  onChanged: (v) => _mobileProvider = v,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Mobile Number'),
                  keyboardType: TextInputType.phone,
                  onChanged: (v) => _mobileNumber = v,
                ),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
                child: const Text('Submit Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}