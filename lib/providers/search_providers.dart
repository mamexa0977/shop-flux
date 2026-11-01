import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasources/remote/search_api.dart';
import '../core/network/dio_client.dart';

final searchApiProvider = Provider<SearchApi>((ref) {
  final dio = ref.watch(dioProvider);
  return SearchApi(dio);
});

final recentSearchesProvider = FutureProvider<List<String>>((ref) async {
  final api = ref.read(searchApiProvider);
  return await api.getRecentSearches();
});

// Provider for the current search query (debounced)
final searchQueryProvider = StateProvider<String>((ref) => '');

// Provider for search suggestions based on the current query
final searchSuggestionsProvider = FutureProvider<List<dynamic>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.length < 2) return [];
  final api = ref.read(searchApiProvider);
  return await api.getSuggestions(query);
});

class SearchActionNotifier extends StateNotifier<AsyncValue<void>> {
  final SearchApi _api;
  final Ref _ref;

  SearchActionNotifier(this._api, this._ref) : super(const AsyncValue.data(null));

  Future<void> clearHistory() async {
    state = const AsyncValue.loading();
    try {
      await _api.clearRecentSearches();
      _ref.invalidate(recentSearchesProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> performSearch(String query) async {
    if (query.trim().isEmpty) return;

    // Record the search on the backend
    try {
      await _api.recordSearch(query);
    } catch (e) {
      // Handle error silently or show a snackbar
      print('Failed to record search: $e');
    }

    // Invalidate recent searches to refresh the list
    _ref.invalidate(recentSearchesProvider);
  }
}

final searchActionProvider = StateNotifierProvider<SearchActionNotifier, AsyncValue<void>>((ref) {
  final api = ref.watch(searchApiProvider);
  return SearchActionNotifier(api, ref);
});