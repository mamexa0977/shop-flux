import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../widgets/recent_searches_widget.dart';
import '../../../../../providers/search_providers.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;

  // Logic remains untouched as requested
  void _onSearchChanged(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      ref.read(searchQueryProvider.notifier).state = query;
    });
  }

  Future<void> _handleSearch(String query) async {
    if (query.trim().isEmpty) return;
    FocusScope.of(context).unfocus();
    if (_searchController.text != query) {
      _searchController.text = query;
    }
    await ref.read(searchActionProvider.notifier).performSearch(query);
    context.push('/search-results?q=${Uri.encodeComponent(query)}');
  }

  void _clearSearch() {
    _searchController.clear();
    ref.read(searchQueryProvider.notifier).state = '';
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Search',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Professional Search Bar Container
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                textInputAction: TextInputAction.search,
                onChanged: _onSearchChanged,
                onSubmitted: _handleSearch,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Search products, categories...',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: Color(0xFF015733),
                  ),
                  suffixIcon:
                      _searchController.text.isNotEmpty
                          ? IconButton(
                            icon: const Icon(
                              Icons.cancel_rounded,
                              color: Colors.grey,
                            ),
                            onPressed: _clearSearch,
                          )
                          : null,
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Color(0xFF015733),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Search Content Area
          Expanded(
            child: Consumer(
              builder: (context, ref, _) {
                final query = ref.watch(searchQueryProvider);

                // Show Recent Searches if query is empty or too short
                if (query.length < 2) {
                  return RecentSearchesWidget(onSearch: _handleSearch);
                }

                final suggestionsAsync = ref.watch(searchSuggestionsProvider);
                return suggestionsAsync.when(
                  loading:
                      () => const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF015733),
                        ),
                      ),
                  error: (e, _) => Center(child: Text('Error: $e')),
                  data: (suggestions) {
                    if (suggestions.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off_rounded,
                              size: 64,
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No matches found',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemCount: suggestions.length,
                      itemBuilder: (ctx, i) {
                        final s = suggestions[i];
                        final isProduct = s['type'] == 'product';

                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          leading: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child:
                                isProduct && s['image'] != null
                                    ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        '${ApiEndpoints.baseUrl}/uploads/products/${s['image']}',
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (ctx, error, stack) => const Icon(
                                              Icons.shopping_bag_outlined,
                                              color: Color(0xFF015733),
                                            ),
                                      ),
                                    )
                                    : Icon(
                                      isProduct
                                          ? Icons.shopping_bag_outlined
                                          : Icons.tag_rounded,
                                      color: const Color(0xFF015733),
                                    ),
                          ),
                          title: Text(
                            s['text'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          subtitle: Text(
                            isProduct ? 'Product' : 'Category',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.north_west_rounded,
                            size: 18,
                            color: Colors.grey,
                          ),
                          onTap: () {
                            _searchController.text = s['text'];
                            _handleSearch(s['text']);
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
