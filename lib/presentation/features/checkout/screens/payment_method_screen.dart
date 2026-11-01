import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? _selected;

  final List<Map<String, dynamic>> methods = [
    {'value': 'chapa', 'label': 'Chapa (Online)', 'icon': Icons.payment},
    {'value': 'cash_on_delivery', 'label': 'Cash on Delivery', 'icon': Icons.money},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Method')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: methods.length,
        itemBuilder: (ctx, i) {
          final m = methods[i];
          return RadioListTile<String>(
            title: Text(m['label']),
            secondary: Icon(m['icon']),
            value: m['value'],
            groupValue: _selected,
            onChanged: (val) => setState(() => _selected = val),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _selected == null ? null : () => Navigator.pop(context, _selected),
          child: const Text('Continue'),
        ),
      ),
    );
  }
}