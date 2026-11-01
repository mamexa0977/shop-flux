import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/image_utils.dart';
import '../../../../providers/seller_product_providers.dart';
import '../../../../data/models/product.dart';
import '../../../../data/models/category.dart'; // if you have category model
import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_endpoints.dart';

class SellerProductFormScreen extends ConsumerStatefulWidget {
  final Product? product; // if null -> add mode
  const SellerProductFormScreen({super.key, this.product});

  @override
  ConsumerState<SellerProductFormScreen> createState() => _SellerProductFormScreenState();
}

class _SellerProductFormScreenState extends ConsumerState<SellerProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late bool _isEditMode;

  // Controllers
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _discountPriceController;
  late TextEditingController _skuController;
  late TextEditingController _stockController;
  late TextEditingController _brandController;
  late TextEditingController _weightController;
  late TextEditingController _dimensionsController;
  int? _selectedCategoryId;
  List<Map<String, dynamic>> _variants = [];
  List<File> _selectedImages = [];
  List<String> _existingImagesToKeep = []; // for edit mode: keep existing image URLs

  // Category list (fetch from API)
  List<Category> _categories = [];
  bool _loadingCategories = true;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.product != null;
    _nameController = TextEditingController(text: widget.product?.name);
    _descriptionController = TextEditingController(text: widget.product?.description);
    _priceController = TextEditingController(text: widget.product?.price?.toString());
    _discountPriceController = TextEditingController(text: widget.product?.discountPrice?.toString());
    _skuController = TextEditingController(text: widget.product?.sku);
    _stockController = TextEditingController(text: widget.product?.stock?.toString());
    _brandController = TextEditingController(text: widget.product?.brand);
    _weightController = TextEditingController(text: widget.product?.weight?.toString());
    _dimensionsController = TextEditingController(text: widget.product?.dimensions);
    _selectedCategoryId = widget.product?.categoryId;
if (_isEditMode && widget.product!.variants != null) {
  _variants = widget.product!.variants!.map((v) => {
    'id': v.id,
    'attributes': v.attributes,
    'sku': v.sku,
    'price': v.price,
    'stock': v.stock,
  }).toList();
}
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final dio = ref.read(dioProvider);
      final response = await dio.get(ApiEndpoints.categories);
      final List<dynamic> data = response.data['data']['categories'];
      setState(() {
        _categories = data.map((json) => Category.fromJson(json)).toList();
        _loadingCategories = false;
      });
    } catch (e) {
      setState(() => _loadingCategories = false);
    }
  }

  void _addVariant() {
    setState(() {
      _variants.add({
        'attributes': {},
        'sku': '',
        'price': 0.0,
        'stock': 0,
      });
    });
  }

  void _removeVariant(int index) {
    setState(() {
      _variants.removeAt(index);
    });
  }

  void _updateVariant(int index, String field, dynamic value) {
    setState(() {
      _variants[index][field] = value;
    });
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final List<XFile> picked = await picker.pickMultiImage();
    setState(() {
      _selectedImages.addAll(picked.map((x) => File(x.path)));
    });
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }
Future<void> _submit() async {
  if (!_formKey.currentState!.validate()) return;
  if (_selectedCategoryId == null) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a category')));
    return;
  }
  if (_selectedImages.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select at least one product image')));
    return;
  }

  final formData = FormData();

  // Add text fields
  formData.fields.add(MapEntry('name', _nameController.text));
  formData.fields.add(MapEntry('description', _descriptionController.text));
  formData.fields.add(MapEntry('price', _priceController.text));
  if (_discountPriceController.text.isNotEmpty) {
    formData.fields.add(MapEntry('discountPrice', _discountPriceController.text));
  }
  formData.fields.add(MapEntry('sku', _skuController.text));
  formData.fields.add(MapEntry('stock', _stockController.text));
  formData.fields.add(MapEntry('brand', _brandController.text));
  if (_weightController.text.isNotEmpty) {
    formData.fields.add(MapEntry('weight', _weightController.text));
  }
  if (_dimensionsController.text.isNotEmpty) {
    formData.fields.add(MapEntry('dimensions', _dimensionsController.text));
  }
  formData.fields.add(MapEntry('categoryId', _selectedCategoryId.toString()));

  // Add variants as JSON string
  if (_variants.isNotEmpty) {
    formData.fields.add(MapEntry('variants', jsonEncode(_variants)));
  }

  // ✅ Add images correctly
  for (int i = 0; i < _selectedImages.length; i++) {
    final file = _selectedImages[i];
    final multipartFile = await MultipartFile.fromFile(file.path, filename: 'image_$i.jpg');
    formData.files.add(MapEntry('images', multipartFile));
  }

  final notifier = ref.read(sellerProductActionProvider.notifier);
  if (_isEditMode) {
    await notifier.updateProduct(widget.product!.id, formData);
  } else {
    await notifier.createProduct(formData);
  }

  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(_isEditMode ? 'Product updated' : 'Product created')),
    );
    context.go('/seller/products');
  }
}  @override
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(_isEditMode ? 'Edit Product' : 'Add Product'),
      backgroundColor: const Color(0xFFFFFAD3),
    ),
    body: _loadingCategories
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Basic info fields (unchanged)
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Product Name*'),
                    validator: (v) => v!.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _priceController,
                          decoration: const InputDecoration(labelText: 'Price*'),
                          keyboardType: TextInputType.number,
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _discountPriceController,
                          decoration: const InputDecoration(labelText: 'Discount Price'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _skuController,
                          decoration: const InputDecoration(labelText: 'SKU'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _stockController,
                          decoration: const InputDecoration(labelText: 'Stock*'),
                          keyboardType: TextInputType.number,
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _brandController,
                    decoration: const InputDecoration(labelText: 'Brand'),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _weightController,
                          decoration: const InputDecoration(labelText: 'Weight (kg)'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _dimensionsController,
                          decoration: const InputDecoration(labelText: 'Dimensions'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<int>(
                    value: _selectedCategoryId,
                    decoration: const InputDecoration(labelText: 'Category*'),
                    items: _categories.map((c) {
                      return DropdownMenuItem(value: c.id, child: Text(c.name));
                    }).toList(),
                    onChanged: (val) => setState(() => _selectedCategoryId = val),
                    validator: (v) => v == null ? 'Select category' : null,
                  ),
                  const SizedBox(height: 24),

                  // Variants section (unchanged)
                  const Text('Variants', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _variants.length,
                    itemBuilder: (ctx, idx) {
                      final variant = _variants[idx];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: variant['sku'],
                                      decoration: const InputDecoration(labelText: 'SKU'),
                                      onChanged: (v) => _updateVariant(idx, 'sku', v),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: variant['price'].toString(),
                                      decoration: const InputDecoration(labelText: 'Price'),
                                      keyboardType: TextInputType.number,
                                      onChanged: (v) => _updateVariant(idx, 'price', double.tryParse(v) ?? 0),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: variant['stock'].toString(),
                                      decoration: const InputDecoration(labelText: 'Stock'),
                                      keyboardType: TextInputType.number,
                                      onChanged: (v) => _updateVariant(idx, 'stock', int.tryParse(v) ?? 0),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _removeVariant(idx),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                initialValue: variant['attributes'].toString(),
                                decoration: const InputDecoration(labelText: 'Attributes (JSON)'),
                                onChanged: (v) {
                                  try {
                                    final map = Map<String, dynamic>.from(jsonDecode(v));
                                    _updateVariant(idx, 'attributes', map);
                                  } catch (_) {}
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  ElevatedButton.icon(
                    onPressed: _addVariant,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Variant'),
                  ),
                  const SizedBox(height: 24),

                  // New Images section
                  const Text('Product Images', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      ..._selectedImages.asMap().entries.map((entry) {
                        return Stack(
                          children: [
                            Image.file(entry.value, width: 80, height: 80, fit: BoxFit.cover),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                icon: const Icon(Icons.close, size: 20, color: Colors.red),
                                onPressed: () => _removeImage(entry.key),
                              ),
                            ),
                          ],
                        );
                      }),
                      if (_selectedImages.length < 10)
                        GestureDetector(
                          onTap: _pickImages,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.add_photo_alternate),
                          ),
                        ),
                    ],
                  ),

                  // ✅ Existing Images (only in edit mode)
                  if (_isEditMode && widget.product!.images != null && widget.product!.images!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text('Existing Images', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: widget.product!.images!.map((img) {
                        return Stack(
                          children: [
                            Image.network(
                              ImageUtils.getFullImageUrl(img.imageUrl),
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 80),
                            ),
                            // Optional: delete button (requires backend API to delete image)
                          ],
                        );
                      }).toList(),
                    ),
                  ],

                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
                    child: Text(_isEditMode ? 'Update Product' : 'Create Product'),
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
    _descriptionController.dispose();
    _priceController.dispose();
    _discountPriceController.dispose();
    _skuController.dispose();
    _stockController.dispose();
    _brandController.dispose();
    _weightController.dispose();
    _dimensionsController.dispose();
    super.dispose();
  }
}