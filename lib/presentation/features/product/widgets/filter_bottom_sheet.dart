import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final Map<String, dynamic> currentFilters;
  final Function(Map<String, dynamic>) onApply;

  const FilterBottomSheet({
    super.key,
    required this.currentFilters,
    required this.onApply,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late TextEditingController _minController;
  late TextEditingController _maxController;
  late RangeValues _priceRange;
  String? _selectedSort;

  final List<String> _sortOptions = ['price_asc', 'price_desc', 'newest', 'popularity'];
  final Map<String, String> _sortLabels = {
    'price_asc': 'Price: Low to High',
    'price_desc': 'Price: High to Low',
    'newest': 'Newest First',
    'popularity': 'Popularity',
  };

  @override
  void initState() {
    super.initState();
    final min = (widget.currentFilters['minPrice'] as num?)?.toDouble() ?? 0;
    final max = (widget.currentFilters['maxPrice'] as num?)?.toDouble() ?? 1000;
    _minController = TextEditingController(text: min.toString());
    _maxController = TextEditingController(text: max.toString());
    _priceRange = RangeValues(min, max);
    _selectedSort = widget.currentFilters['sort'] as String?;
  }

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  void _updateRangeFromText() {
    final min = double.tryParse(_minController.text) ?? 0;
    final max = double.tryParse(_maxController.text) ?? 1000;
    setState(() {
      _priceRange = RangeValues(min, max);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter & Sort',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Price Range with Text Fields
          const Text('Price Range'),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _minController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Min',
                    prefixText: '\$',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => _updateRangeFromText(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: _maxController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Max',
                    prefixText: '\$',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => _updateRangeFromText(),
                ),
              ),
            ],
          ),
          RangeSlider(
            values: _priceRange,
            min: 0,
            max: 1000,
            divisions: 100,
            labels: RangeLabels(
              '\$${_priceRange.start.round()}',
              '\$${_priceRange.end.round()}',
            ),
            onChanged: (values) {
              setState(() {
                _priceRange = values;
                _minController.text = values.start.toStringAsFixed(0);
                _maxController.text = values.end.toStringAsFixed(0);
              });
            },
          ),
          const SizedBox(height: 16),

          // Sort Options
          const Text('Sort By'),
          ..._sortOptions.map((option) => RadioListTile<String>(
                title: Text(_sortLabels[option]!),
                value: option,
                groupValue: _selectedSort,
                onChanged: (value) => setState(() => _selectedSort = value),
                dense: true,
              )),
          const SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    final filters = {
                      'minPrice': _priceRange.start,
                      'maxPrice': _priceRange.end,
                      if (_selectedSort != null) 'sort': _selectedSort,
                    };
                    widget.onApply(filters);
                    Navigator.pop(context);
                  },
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}