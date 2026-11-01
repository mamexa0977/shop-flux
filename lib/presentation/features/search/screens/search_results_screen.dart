import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../data/models/product.dart';
import '../../../../providers/search_providers.dart';
// adjust path

final searchResultsProvider = FutureProvider.family<List<Product>, String>((
  ref,
  query,
) async {
  if (query.isEmpty) return [];
  final api = ref.read(searchApiProvider);
  final response = await api.searchProducts(query);
  // Assuming response.data['data']['products'] is the list
  final List productsJson = response['data']['products'];
  return productsJson.map((json) => Product.fromJson(json)).toList();
});

class SearchResultsScreen extends ConsumerWidget {
  final String query;
  const SearchResultsScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultsAsync = ref.watch(searchResultsProvider(query));

    return Scaffold(
      appBar: AppBar(title: Text('Results for "$query"')),
      body: resultsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (products) {
          if (products.isEmpty) {
            return const Center(child: Text('No products found.'));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: products.length,
            itemBuilder: (ctx, i) {
              final p = products[i];
              // Get primary image URL
              // Add this import (or use your existing ApiEndpoints)

              // Then when building imageUrl:
              String? imageUrl;
              if (p.images != null && p.images!.isNotEmpty) {
                final primaryImage = p.images!.firstWhere(
                  (img) => img.isPrimary == true,
                  orElse: () => p.images!.first,
                );
                // ✅ Construct full URL
                imageUrl =
                    '${ApiEndpoints.baseUrl}/uploads/products/${primaryImage.imageUrl}';
              } else {
                imageUrl = null;
              }

              return Card(
                child: InkWell(
                  onTap: () => context.push('/product/${p.id}'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child:
                            imageUrl != null
                                ? Image.network(imageUrl, fit: BoxFit.cover)
                                : Container(color: Colors.grey[300]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (p.discountPrice != null)
                              Row(
                                children: [
                                  Text(
                                    '\$${p.discountPrice!.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Color(0xFF015733),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '\$${p.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
                            else
                              Text(
                                '\$${p.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Color(0xFF015733),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
