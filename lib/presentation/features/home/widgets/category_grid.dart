import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../data/models/category.dart';

class CategoryGrid extends StatelessWidget {
  final List<Category> categories;
  const CategoryGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Categories',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          // Add one extra item for "All"
          itemCount: categories.length + 1,
          itemBuilder: (ctx, i) {
            if (i == 0) {
              // "All" tile
              return GestureDetector(
                onTap: () => context.push('/products'), // new route
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: const Icon(Icons.apps, size: 30),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'All',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              );
            }
            // Regular category tile (i-1 index)
            final cat = categories[i - 1];
            return GestureDetector(
              onTap: () => context.push('/category/${cat.slug}'),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        cat.image != null
                            ? NetworkImage(
                              '${ApiEndpoints.baseUrl}/uploads/categories/${cat.image}',
                            )
                            : null,
                    child:
                        cat.image == null ? const Icon(Icons.category) : null,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cat.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
