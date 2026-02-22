import 'product.dart';

class FlashSale {
  final int id;
  final String name;
  final DateTime startTime;
  final DateTime endTime;
  final bool? isActive;
  final List<FlashSaleProduct> products;

  FlashSale({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    this.isActive,
    required this.products,
  });
}

class FlashSaleProduct {
  final Product product;
  final double discountPrice;

  FlashSaleProduct({required this.product, required this.discountPrice});
}