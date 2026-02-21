// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../providers/product_providers.dart';

// class ProductListController extends StateNotifier<AsyncValue<void>> {
//   final Ref _ref;

//   ProductListController(this._ref) : super(const AsyncValue.data(null));

//   Future<void> loadMore() async {
//     final notifier = _ref.read(productListProvider.notifier);
//     state = const AsyncValue.loading();
//     try {
//       await notifier.loadNextPage();
//       state = const AsyncValue.data(null);
//     } catch (e, st) {
//       state = AsyncValue.error(e, st);
//     }
//   }

//   Future<void> applyFilters(Map<String, dynamic> filters) async {
//     final notifier = _ref.read(productListProvider.notifier);
//     state = const AsyncValue.loading();
//     try {
//       notifier.applyFilters(filters);
//       state = const AsyncValue.data(null);
//     } catch (e, st) {
//       state = AsyncValue.error(e, st);
//     }
//   }

//   Future<void> refresh() async {
//     final notifier = _ref.read(productListProvider.notifier);
//     state = const AsyncValue.loading();
//     try {
//       notifier.refresh();
//       state = const AsyncValue.data(null);
//     } catch (e, st) {
//       state = AsyncValue.error(e, st);
//     }
//   }
// }

// final productListControllerProvider = StateNotifierProvider<ProductListController, AsyncValue<void>>((ref) {
//   return ProductListController(ref);
// });