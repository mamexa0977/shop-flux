import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasources/remote/public_api.dart';
import '../data/models/product.dart';
import '../data/models/flash_sale.dart';
import '../core/network/dio_client.dart';

final flashSaleApiProvider = Provider<PublicApi>((ref) {
  final dio = ref.watch(dioProvider);
  return PublicApi(dio);
});
final flashSalesProvider = FutureProvider<List<FlashSale>>((ref) async {
  final api = ref.read(flashSaleApiProvider);
  final response = await api.getFlashSales();
  
  // If the response doesn't have the expected structure, return empty list
  if (response['data'] == null || response['data']['flashSales'] == null) {
    return [];
  }
  
  final data = response['data']['flashSales'] as List;
  return data.map((e) {
    final productsJson = e['Products'] as List? ?? [];
    final products = productsJson.map((pJson) {
      final product = Product.fromJson(pJson);
      final discountStr = pJson['FlashSaleProduct']?['discountPrice'] ?? '0';
      final discountPrice = double.tryParse(discountStr.toString()) ?? 0.0;
      return FlashSaleProduct(product: product, discountPrice: discountPrice);
    }).toList();

    return FlashSale(
      id: e['id'],
      name: e['name'] ?? '',
      startTime: DateTime.tryParse(e['startTime'] ?? '') ?? DateTime.now(),
      endTime: DateTime.tryParse(e['endTime'] ?? '') ?? DateTime.now(),
      isActive: e['isActive'],
      products: products,
    );
  }).toList();
});