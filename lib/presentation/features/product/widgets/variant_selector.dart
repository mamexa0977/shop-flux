import 'package:flutter/material.dart';
import '../../../../data/models/product_variant.dart';
 

class VariantSelector extends StatefulWidget {
  final List<ProductVariant> variants;
  const VariantSelector({super.key, required this.variants});

  @override
  State<VariantSelector> createState() => _VariantSelectorState();
}

class _VariantSelectorState extends State<VariantSelector> {
  ProductVariant? _selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Options', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: widget.variants.map((v) {
            final label = v.attributes.values.join(' / ');
            return ChoiceChip(
              label: Text(label),
              selected: _selected == v,
              onSelected: (sel) => setState(() => _selected = v),
            );
          }).toList(),
        ),
      ],
    );
  }
}