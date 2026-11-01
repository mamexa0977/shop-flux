import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/seller_settings_providers.dart';
import '../../../common_widgets/error_view.dart';

class SellerSettingsScreen extends ConsumerStatefulWidget {
  const SellerSettingsScreen({super.key});

  @override
  ConsumerState<SellerSettingsScreen> createState() => _SellerSettingsScreenState();
}

class _SellerSettingsScreenState extends ConsumerState<SellerSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _controllers['businessName'] = TextEditingController();
    _controllers['businessRegNumber'] = TextEditingController();
    _controllers['businessAddress'] = TextEditingController();
    _controllers['businessPhone'] = TextEditingController();
    _controllers['bankName'] = TextEditingController();
    _controllers['bankAccountName'] = TextEditingController();
    _controllers['bankAccountNumber'] = TextEditingController();
    _controllers['mobileMoneyProvider'] = TextEditingController();
    _controllers['mobileMoneyNumber'] = TextEditingController();
  }

  @override
  void dispose() {
    for (var c in _controllers.values) c.dispose();
    super.dispose();
  }

  Future<void> _loadAndPopulate() async {
    final storeInfo = await ref.read(sellerStoreInfoProvider.future);
    setState(() {
      _controllers['businessName']?.text = storeInfo['businessName'] ?? '';
      _controllers['businessRegNumber']?.text = storeInfo['businessRegNumber'] ?? '';
      _controllers['businessAddress']?.text = storeInfo['businessAddress'] ?? '';
      _controllers['businessPhone']?.text = storeInfo['businessPhone'] ?? '';
      _controllers['bankName']?.text = storeInfo['bankName'] ?? '';
      _controllers['bankAccountName']?.text = storeInfo['bankAccountName'] ?? '';
      _controllers['bankAccountNumber']?.text = storeInfo['bankAccountNumber'] ?? '';
      _controllers['mobileMoneyProvider']?.text = storeInfo['mobileMoneyProvider'] ?? '';
      _controllers['mobileMoneyNumber']?.text = storeInfo['mobileMoneyNumber'] ?? '';
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    String? _nullIfEmpty(String? value) => (value == null || value.trim().isEmpty) ? null : value.trim();
    final data = {
    'businessName': _nullIfEmpty(_controllers['businessName']?.text),
    'businessRegNumber': _nullIfEmpty(_controllers['businessRegNumber']?.text),
    'businessAddress': _nullIfEmpty(_controllers['businessAddress']?.text),
    'businessPhone': _nullIfEmpty(_controllers['businessPhone']?.text),
    'bankName': _nullIfEmpty(_controllers['bankName']?.text),
    'bankAccountName': _nullIfEmpty(_controllers['bankAccountName']?.text),
    'bankAccountNumber': _nullIfEmpty(_controllers['bankAccountNumber']?.text),
    'mobileMoneyProvider': _nullIfEmpty(_controllers['mobileMoneyProvider']?.text),
    'mobileMoneyNumber': _nullIfEmpty(_controllers['mobileMoneyNumber']?.text),
    };
    final notifier = ref.read(sellerSettingsActionProvider.notifier);
    await notifier.updateStoreInfo(data);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Settings updated')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final storeInfoAsync = ref.watch(sellerStoreInfoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Settings'),
        backgroundColor: const Color(0xFFFFFAD3),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(sellerStoreInfoProvider),
          ),
        ],
      ),
      body: storeInfoAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: ErrorView(error: error.toString())),
        data: (_) {
          // populate once
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_controllers['businessName']?.text.isEmpty == true) _loadAndPopulate();
          });
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(controller: _controllers['businessName'], decoration: const InputDecoration(labelText: 'Business Name')),
                  TextFormField(controller: _controllers['businessRegNumber'], decoration: const InputDecoration(labelText: 'Registration Number')),
                  TextFormField(controller: _controllers['businessAddress'], decoration: const InputDecoration(labelText: 'Business Address'), maxLines: 2),
                  TextFormField(controller: _controllers['businessPhone'], decoration: const InputDecoration(labelText: 'Business Phone')),
                  const Divider(),
                  const Text('Bank Details', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextFormField(controller: _controllers['bankName'], decoration: const InputDecoration(labelText: 'Bank Name')),
                  TextFormField(controller: _controllers['bankAccountName'], decoration: const InputDecoration(labelText: 'Account Name')),
                  TextFormField(controller: _controllers['bankAccountNumber'], decoration: const InputDecoration(labelText: 'Account Number')),
                  const Divider(),
                  const Text('Mobile Money', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextFormField(controller: _controllers['mobileMoneyProvider'], decoration: const InputDecoration(labelText: 'Provider (mtn/airtel/telecel)')),
                  TextFormField(controller: _controllers['mobileMoneyNumber'], decoration: const InputDecoration(labelText: 'Mobile Number')),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
                    child: const Text('Save Changes'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}