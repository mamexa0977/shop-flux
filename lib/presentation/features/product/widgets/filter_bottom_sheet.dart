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
  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();
  String? _selectedSort;

  final List<String> _sortOptions = ['price_asc', 'price_desc', 'newest'];
  final Map<String, String> _sortLabels = {
    'price_asc': 'Price: Low to High',
    'price_desc': 'Price: High to Low',
    'newest': 'Newest First',
  };

  @override
  void initState() {
    super.initState();
    // Initialize from current filters (if any)
    if (widget.currentFilters.containsKey('minPrice')) {
      _minController.text = widget.currentFilters['minPrice'].toString();
    }
    if (widget.currentFilters.containsKey('maxPrice')) {
      _maxController.text = widget.currentFilters['maxPrice'].toString();
    }
    _selectedSort = widget.currentFilters['sort'] as String?;
  }

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  void _clearFilters() {
    setState(() {
      _minController.clear();
      _maxController.clear();
      _selectedSort = null;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter & Sort',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: _clearFilters,
                child: const Text('Clear'),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Price Range - Text Fields Only
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
                ),
              ),
            ],
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
                    final filters = <String, dynamic>{};
                    if (_minController.text.isNotEmpty) {
                      filters['minPrice'] = double.parse(_minController.text);
                    }
                    if (_maxController.text.isNotEmpty) {
                      filters['maxPrice'] = double.parse(_maxController.text);
                    }
                    if (_selectedSort != null) {
                      filters['sort'] = _selectedSort;
                    }
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