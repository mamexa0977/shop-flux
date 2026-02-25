import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasources/remote/product_api.dart';
import '../data/repositories/product_repository.dart';
import '../data/repositories_impl/product_repository_impl.dart';
import '../core/network/dio_client.dart';
import '../data/models/product.dart';

// Repository provider
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final api = ProductApi(dio);
  return ProductRepositoryImpl(api);
});

// Featured products
final featuredProductsProvider = FutureProvider<List<Product>>((ref) async {
  final repo = ref.read(productRepositoryProvider);
  return repo.getFeaturedProducts();
});

// New arrivals
final newArrivalsProvider = FutureProvider<List<Product>>((ref) async {
  final repo = ref.read(productRepositoryProvider);
  return repo.getNewArrivals();
});

// Best sellers
final bestSellersProvider = FutureProvider<List<Product>>((ref) async {
  final repo = ref.read(productRepositoryProvider);
  return repo.getBestSellers();
});

// // Product list with pagination and filters
// class ProductListNotifier extends StateNotifier<AsyncValue<List<Product>>> {
//   final ProductRepository _repository;
//   final String? _categorySlug;
//   int _currentPage = 1;
//   bool _hasMore = true;
//   Map<String, dynamic> _currentFilters = {};

//   ProductListNotifier(this._repository, this._categorySlug)
//     : super(const AsyncValue.loading()) {
//     _loadFirstPage();
//   }
// Future<void> _loadFirstPage() async {
//     state = const AsyncValue.loading();
//     try {
//       List<Product> products;
//       if (_categorySlug != null) {
//         // Use category endpoint (no pagination yet)
//         products = await _repository.getProductsByCategory(_categorySlug!);
//         _hasMore = false; // no pagination for now
//       } else {
//         products = await _repository.getProducts(page: 1, limit: 10, filters: _currentFilters);
//         _hasMore = products.length == 10;
//       }
//       state = AsyncValue.data(products);
//     } catch (e, st) {
//       state = AsyncValue.error(e, st);
//     }
//   }  Future<void> loadNextPage() async {
//     if (!_hasMore) return;
//     final currentList = state.value ?? [];
//     state = AsyncValue.data(
//       currentList,
//     ); // keep previous data while loading more
//     try {
//       final nextPage = await _repository.getProducts(
//         page: _currentPage + 1,
//         limit: 10,
//         filters: _currentFilters,
//       );
//       _hasMore = nextPage.length == 10;
//       _currentPage++;
//       state = AsyncValue.data([...currentList, ...nextPage]);
//     } catch (e, st) {
//       // Optionally show error, but keep old data
//     }
//   }

//   void applyFilters(Map<String, dynamic> filters) {
//     _currentFilters = filters;
//     _currentPage = 1;
//     _loadFirstPage();
//   }

//   void refresh() {
//     _currentPage = 1;
//     _loadFirstPage();
//   }
// }

// product_providers.dart
class ProductListNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  final ProductRepository _repository;
  final String? _categorySlug;
  int _currentPage = 1;
  bool _hasMore = true;
  Map<String, dynamic> _currentFilters = {};
 Map<String, dynamic> get currentFilters => _currentFilters;
  ProductListNotifier(this._repository, this._categorySlug)
      : super(const AsyncValue.loading()) {
    _loadFirstPage();
  }

  Future<void> _loadFirstPage() async {
    state = const AsyncValue.loading();
    try {
      List<Product> products;
      if (_categorySlug != null) {
        products = await _repository.getProductsByCategory(
          _categorySlug!,
          page: 1,
          limit: 10,
          filters: _currentFilters,
        );
      } else {
        products = await _repository.getProducts(
          page: 1,
          limit: 10,
          filters: _currentFilters,
        );
      }
      _hasMore = products.length == 10;
      state = AsyncValue.data(products);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loadNextPage() async {
    if (!_hasMore) return;
    final currentList = state.value ?? [];
    state = AsyncValue.data(currentList); // keep old data while loading

    try {
      List<Product> nextPage;
      if (_categorySlug != null) {
        nextPage = await _repository.getProductsByCategory(
          _categorySlug!,
          page: _currentPage + 1,
          limit: 10,
          filters: _currentFilters,
        );
      } else {
        nextPage = await _repository.getProducts(
          page: _currentPage + 1,
          limit: 10,
          filters: _currentFilters,
        );
      }
      _hasMore = nextPage.length == 10;
      _currentPage++;
      state = AsyncValue.data([...currentList, ...nextPage]);
    } catch (e, st) {
      // optionally show error, but keep old data
    }
  }

  void applyFilters(Map<String, dynamic> filters) {
    _currentFilters = filters;
    _currentPage = 1;
    _loadFirstPage();
  }

  void refresh() {
    _currentPage = 1;
    _loadFirstPage();
  }
}


final productListProvider = StateNotifierProvider.family<
  ProductListNotifier,
  AsyncValue<List<Product>>,
  String?
>((ref, categorySlug) {
  final repo = ref.read(productRepositoryProvider);
  return ProductListNotifier(repo, categorySlug);
});

// Product detail
final productDetailProvider = FutureProvider.family<Product, int>((
  ref,
  id,
) async {
  final repo = ref.read(productRepositoryProvider);
  return repo.getProduct(id);
});

// Products by category
final productsByCategoryProvider = FutureProvider.family<List<Product>, String>(
  (ref, slug) async {
    final repo = ref.read(productRepositoryProvider);
    return repo.getProductsByCategory(slug);
  },
);
