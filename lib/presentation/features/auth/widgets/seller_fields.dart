import 'package:ecom_frontend/presentation/common_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/validators.dart';

class SellerFields extends StatelessWidget {
  final Map<String, TextEditingController> controllers;

  const SellerFields({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: 'Business Name',
          controller: controllers['businessName'],
          validator: (v) => Validators.required(v, 'Business name'),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Business Registration Number',
          controller: controllers['businessRegNumber'],
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Business Address',
          controller: controllers['businessAddress'],
          validator: (v) => Validators.required(v, 'Business address'),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Business Phone',
          keyboardType: TextInputType.phone,
          controller: controllers['businessPhone'],
          validator: (v) => Validators.phone(v),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Bank Name',
          controller: controllers['bankName'],
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Bank Account Name',
          controller: controllers['bankAccountName'],
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Bank Account Number',
          keyboardType: TextInputType.number,
          controller: controllers['bankAccountNumber'],
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: controllers['mobileMoneyProvider']!.text.isEmpty
              ? null
              : controllers['mobileMoneyProvider']?.text,
          items: ['mtn', 'airtel', 'telecel']
              .map((e) => DropdownMenuItem(value: e, child: Text(e.toUpperCase())))
              .toList(),
          onChanged: (value) {
            controllers['mobileMoneyProvider']?.text = value ?? '';
          },
          decoration: const InputDecoration(labelText: 'Mobile Money Provider'),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Mobile Money Number',
          keyboardType: TextInputType.phone,
          controller: controllers['mobileMoneyNumber'],
        ),
      ],
    );
  }
}