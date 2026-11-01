import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../providers/seller_promotion_providers.dart';
import '../../../../providers/seller_product_providers.dart';

class SellerDiscountFormScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic>? discount;
  const SellerDiscountFormScreen({super.key, this.discount});

  @override
  ConsumerState<SellerDiscountFormScreen> createState() => _SellerDiscountFormScreenState();
}

class _SellerDiscountFormScreenState extends ConsumerState<SellerDiscountFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late bool _isEdit;
  late TextEditingController _nameController;
  late String _type;
  late TextEditingController _valueController;
  late String _appliesTo;
  late List<int> _selectedProductIds;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  DateTime? _startDate, _endDate;

  @override
  void initState() {
    super.initState();
    _isEdit = widget.discount != null;
    _nameController = TextEditingController(text: widget.discount?['name']);
    _type = widget.discount?['type'] ?? 'percentage';
    _valueController = TextEditingController(text: widget.discount?['value']?.toString());
    _appliesTo = widget.discount?['appliesTo'] ?? 'all_products';
    _selectedProductIds = [];
    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
    if (widget.discount != null) {
      _startDate = DateTime.tryParse(widget.discount!['startDate']);
      _endDate = DateTime.tryParse(widget.discount!['endDate']);
      _startDateController.text = _startDate != null ? '${_startDate!.year}-${_startDate!.month}-${_startDate!.day}' : '';
      _endDateController.text = _endDate != null ? '${_endDate!.year}-${_endDate!.month}-${_endDate!.day}' : '';
    }
  }

  Future<void> _selectDate(TextEditingController controller, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          _startDateController.text = '${picked.year}-${picked.month}-${picked.day}';
        } else {
          _endDate = picked;
          _endDateController.text = '${picked.year}-${picked.month}-${picked.day}';
        }
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final data = {
      'name': _nameController.text,
      'type': _type,
      'value': double.parse(_valueController.text),
      'appliesTo': _appliesTo,
      'startDate': _startDate?.toIso8601String(),
      'endDate': _endDate?.toIso8601String(),
    };
    if (_appliesTo == 'selected_products') {
      data['productIds'] = _selectedProductIds;
    }

    final notifier = ref.read(sellerPromotionActionProvider.notifier);
    if (_isEdit) {
      await notifier.updateDiscount(widget.discount!['id'], data);
    } else {
      await notifier.createDiscount(data);
    }
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_isEdit ? 'Discount updated' : 'Discount created')));
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(sellerProductListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit Discount' : 'Create Discount'),
        backgroundColor: const Color(0xFFFFFAD3),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Discount Name*'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _type,
                decoration: const InputDecoration(labelText: 'Type*'),
                items: const [
                  DropdownMenuItem(value: 'percentage', child: Text('Percentage (%)')),
                  DropdownMenuItem(value: 'fixed', child: Text('Fixed Amount (ETB)')),
                ],
                onChanged: (v) => setState(() => _type = v!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _valueController,
                decoration: const InputDecoration(labelText: 'Value*'),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _appliesTo,
                decoration: const InputDecoration(labelText: 'Applies To*'),
                items: const [
                  DropdownMenuItem(value: 'all_products', child: Text('All Products')),
                  DropdownMenuItem(value: 'selected_products', child: Text('Selected Products')),
                ],
                onChanged: (v) => setState(() => _appliesTo = v!),
              ),
              if (_appliesTo == 'selected_products') ...[
                const SizedBox(height: 16),
                productsAsync.when(
                  loading: () => const CircularProgressIndicator(),
                  error: (_, __) => const Text('Failed to load products'),
                  data: (products) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Select Products', style: TextStyle(fontWeight: FontWeight.bold)),
                      ...products.map((p) => CheckboxListTile(
                        title: Text(p.name),
                        value: _selectedProductIds.contains(p.id),
                        onChanged: (checked) {
                          setState(() {
                            if (checked == true) {
                              _selectedProductIds.add(p.id);
                            } else {
                              _selectedProductIds.remove(p.id);
                            }
                          });
                        },
                      )),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 16),
              TextFormField(
                controller: _startDateController,
                decoration: const InputDecoration(labelText: 'Start Date'),
                readOnly: true,
                onTap: () => _selectDate(_startDateController, true),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _endDateController,
                decoration: const InputDecoration(labelText: 'End Date'),
                readOnly: true,
                onTap: () => _selectDate(_endDateController, false),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
                child: Text(_isEdit ? 'Update Discount' : 'Create Discount'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _valueController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }
}