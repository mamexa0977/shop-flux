import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../data/models/cart.dart';
import '../../../../data/models/product.dart';
import '../../../../data/models/product_variant.dart';
import '../../../../providers/product_providers.dart';
import '../../../../providers/review_providers.dart';
import '../../../../providers/wishlist_providers.dart';
import '../../../../providers/cart_providers.dart'; // your cart provider file
import '../../../common_widgets/error_view.dart';
import '../../../common_widgets/loading_indicator.dart';
import '../widgets/variant_selector.dart';
import '../../../../providers/cart_providers.dart'; // adjust path to your cart providers file
import '../widgets/review_item.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final int productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  ProductVariant? _selectedVariant;
  int _quantity = 1;

@override
void initState() {
  super.initState();
  // Listen for product data to set initial variant
  ref.listenManual(productDetailProvider(widget.productId), (previous, next) {
    if (next is AsyncData) {
      final product = next.value;
      final variants = product?.variants; // nullable
      if (variants != null && variants.isNotEmpty) {
        setState(() {
          _selectedVariant = variants.first;
        });
      }
    }
  });
}

  double _getCurrentPrice(Product product) {
    if (_selectedVariant != null) {
      final v = _selectedVariant!;
      return v.discountPrice ??
          v.price ??
          0.0; // fallback to 0.0 if price is null
    }
    return product.discountPrice ?? product.price ?? 0.0;
  }

  // Check if current selection is in cart using CartData
  bool _isInCart(CartData cart, Product product) {
    return cart.items.any(
      (item) =>
          item.productId == product.id &&
          item.variantId == _selectedVariant?.id,
    );
  }

  // Find cart item if exists
  CartItem? _findCartItem(CartData cart, Product product) {
    try {
      return cart.items.firstWhere(
        (item) =>
            item.productId == product.id &&
            item.variantId == _selectedVariant?.id,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final productAsync = ref.watch(productDetailProvider(widget.productId));
    final cartAsync = ref.watch(cartProvider); // FutureProvider<CartData>
    final cartAction = ref.watch(cartActionProvider);
    final wishlistAsync = ref.watch(wishlistProvider);
    final wishlistAction = ref.watch(wishlistActionProvider);

    // Determine wishlist status
    final isInWishlist = wishlistAsync.maybeWhen(
      data: (items) => items.any((item) => item.productId == widget.productId),
      orElse: () => false,
    );

    // Listen for wishlist errors
    ref.listen(wishlistActionProvider, (_, next) {
      next.whenOrNull(
        error: (e, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Wishlist error: $e'),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    });

    // Listen for cart errors
    ref.listen(cartActionProvider, (_, next) {
      next.whenOrNull(
        error: (e, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Cart error: $e'),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: productAsync.when(
        loading: () => const LoadingIndicator(),
        error: (e, _) => ErrorView(error: e.toString()),
        data: (product) {
          return CustomScrollView(
            slivers: [
              // SliverAppBar with wishlist icon (unchanged)
              SliverAppBar(
                expandedHeight: 400.0,
                pinned: true,
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.black87),
                actions: [
                  IconButton(
                    icon:
                        wishlistAction.isLoading
                            ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                            : Icon(
                              isInWishlist
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isInWishlist ? Colors.red : Colors.black87,
                            ),
                    onPressed:
                        wishlistAction.isLoading
                            ? null
                            : () {
                              final notifier = ref.read(
                                wishlistActionProvider.notifier,
                              );
                              if (isInWishlist) {
                                notifier.removeItem(widget.productId);
                              } else {
                                notifier.addItem(widget.productId);
                              }
                            },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background:
                      (product.images != null && product.images!.isNotEmpty)
                          ? PageView(
                            children:
                                product.images!
                                    .where((img) => img.imageUrl != null)
                                    .map(
                                      (img) => Image.network(
                                        '${ApiEndpoints.baseUrl}/uploads/profiles/${img.imageUrl}',
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stack) =>
                                                const Center(
                                                  child: Icon(
                                                    Icons.broken_image,
                                                  ),
                                                ),
                                      ),
                                    )
                                    .toList(),
                          )
                          : Container(
                            color: Colors.grey.shade100,
                            child: const Center(
                              child: Icon(
                                Icons.image,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                ),
              ),

              // Product details content
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  transform: Matrix4.translationValues(0, -20, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product.seller?.name ?? 'Unknown Store',
                          style: const TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Price (dynamic)
                        Row(
                          children: [
                            Text(
                              '\$${_getCurrentPrice(product).toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (_selectedVariant == null &&
                                product.discountPrice != null) ...[
                              const SizedBox(width: 12),
                              Text(
                                '\$${product.price}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade500,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Ratings pill (unchanged)
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 6),
                                  const Text(
                                    '4.8',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    ' Ratings',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 20,
                                width: 1,
                                color: Colors.grey.shade300,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.person_outline,
                                    size: 20,
                                    color: Colors.grey.shade700,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${product.reviews?.length ?? 0} ',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Reviews',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Variants
                        if (product.variants != null &&
                            product.variants!.isNotEmpty)
                          VariantSelector(
                            variants: product.variants!,
                            selectedVariant: _selectedVariant,
                            onVariantChanged: (variant) {
                              setState(() {
                                _selectedVariant = variant;
                                // Reset quantity based on cart if exists
                                final cartData = cartAsync.value;
                                if (cartData != null) {
                                  final existing = _findCartItem(
                                    cartData,
                                    product,
                                  );
                                  _quantity = existing?.quantity ?? 1;
                                } else {
                                  _quantity = 1;
                                }
                              });
                            },
                          ),
                        const SizedBox(height: 24),

                        // Description
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.description ??
                              'No description available for this item.',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            height: 1.5,
                          ),
                        ),
                        const Divider(height: 48),

                        // Reviews
                        const Text(
                          'Reviews',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (product.reviews == null || product.reviews!.isEmpty)
                          Text(
                            'No reviews yet',
                            style: TextStyle(color: Colors.grey.shade500),
                          )
                        else
                          Column(
                            children:
                                product.reviews!
                                    .map((r) => ReviewItem(review: r))
                                    .toList(),
                          ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),

      // Bottom bar with cart integration
      bottomNavigationBar: productAsync.when(
        loading: () => null,
        error: (e, _) => null,
        data: (product) {
          return cartAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => const SizedBox.shrink(), // or show retry
            data: (cartData) {
              final inCart = _isInCart(cartData, product);
              final existingItem = _findCartItem(cartData, product);
              final currentPrice = _getCurrentPrice(product);
              final isCartLoading = cartAction.isLoading;

              return Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 16,
                  bottom:
                      MediaQuery.of(context).padding.bottom > 0
                          ? MediaQuery.of(context).padding.bottom
                          : 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          '\$${(currentPrice * _quantity).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed:
                                    isCartLoading
                                        ? null
                                        : () {
                                          if (_quantity > 1) {
                                            setState(() => _quantity--);
                                          }
                                        },
                              ),
                              Text(
                                '$_quantity',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed:
                                    isCartLoading
                                        ? null
                                        : () {
                                          // Optionally check stock
                                          setState(() => _quantity++);
                                        },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed:
                          isCartLoading
                              ? null
                              : () async {
                                final notifier = ref.read(
                                  cartActionProvider.notifier,
                                );
                                if (inCart && existingItem != null) {
                                  await notifier.updateItem(
                                    existingItem.id,
                                    _quantity,
                                  );
                                } else {
                                  await notifier.addItem(
                                    product.id,
                                    _selectedVariant?.id,
                                    _quantity,
                                  );
                                }
                                // Optionally show success message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      inCart ? 'Cart updated' : 'Added to cart',
                                    ),
                                  ),
                                );
                              },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6D00),
                        minimumSize: const Size(double.infinity, 54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        inCart ? 'Update Cart' : 'Add to Cart',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
