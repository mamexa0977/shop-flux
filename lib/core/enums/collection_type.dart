// lib/core/enums/collection_type.dart
enum CollectionType {
  featured,
  newArrivals,
  bestSellers,
}

extension CollectionTypeExtension on CollectionType {
  String get title {
    switch (this) {
      case CollectionType.featured:
        return 'Featured Products';
      case CollectionType.newArrivals:
        return 'New Arrivals';
      case CollectionType.bestSellers:
        return 'Best Sellers';
    }
  }
}