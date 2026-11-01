
import 'package:ecom_frontend/presentation/features/product/screens/product_detail_screen.dart';
import 'package:ecom_frontend/presentation/features/product/screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/enums/collection_type.dart';
import '../data/models/flash_sale.dart';
import '../data/models/order.dart';
import '../data/models/product.dart';
import '../data/models/seller_order_group.dart';
import '../presentation/collection/collection_products_screen.dart';
import '../presentation/features/home/widgets/flash_sale_products_screen.dart';
import '../presentation/features/order/screens/order_detail_screen.dart';
import '../presentation/features/order/screens/orders_list_screen.dart';
import '../presentation/features/search/screens/search_results_screen.dart';
import '../presentation/features/seller/screens/seller_discount_form_screen.dart';
import '../presentation/features/seller/screens/seller_discount_list_screen.dart';
import '../presentation/features/seller/screens/seller_flash_sale_list_screen.dart';
import '../presentation/features/seller/screens/seller_flash_sale_participate_screen.dart';
import '../presentation/features/seller/screens/seller_product_form_screen.dart';
import '../presentation/features/seller/screens/seller_product_list_screen.dart';
import '../presentation/features/seller/screens/seller_settings_screen.dart';
import '../presentation/features/seller/screens/seller_wallet_screen.dart';
import '../presentation/features/seller/screens/seller_withdrawal_screen.dart';
import '../providers/auth_state_provider.dart';

// Import your screens
import '../presentation/features/auth/screens/login_screen.dart';
import '../presentation/features/checkout/screens/checkout_screen.dart';
import '../presentation/features/checkout/screens/chapa_webview_screen.dart';
import '../presentation/features/checkout/screens/order_confirmation_screen.dart';
import '../presentation/features/address/screen/address_list_screen.dart';
import '../presentation/features/auth/screens/register_screen.dart';
import '../presentation/features/auth/screens/phone_verification_screen.dart';
import '../presentation/features/home/screens/home_screen.dart';
import '../presentation/features/cart/screens/cart_screen.dart';
import '../presentation/features/search/screens/search_screen.dart';
import '../presentation/features/wishlist/screens/wishlist_screen.dart';
import '../presentation/features/auth/screens/profile_screen.dart';
import '../presentation/features/auth/screens/edit_profile_screen.dart';
import '../presentation/features/auth/screens/change_password_screen.dart';

// Seller imports
import '../presentation/features/seller/screens/seller_dashboard_screen.dart';
import '../presentation/features/seller/screens/seller_home_screen.dart';
import '../presentation/features/seller/screens/seller_order_list_screen.dart';
import '../presentation/features/seller/screens/seller_order_detail_screen.dart';
import '../presentation/features/seller/screens/seller_return_list_screen.dart';
import '../presentation/features/seller/screens/seller_inventory_screen.dart';

// Import the BottomNavBar widget (buyer)
import '../presentation/common_widgets/bottom_nav_bar.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // Watch auth state to trigger redirects when login/logout happens
  final authState = ref.watch(authStateProvider);
  final isLoggedIn = authState != null;
  final userRole = authState?.role;

  return GoRouter(
    initialLocation: '/home',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isAuthRoute = state.matchedLocation.startsWith('/login') ||
          state.matchedLocation.startsWith('/register') ||
          state.matchedLocation.startsWith('/verify');

      // Guest allowed routes (buyer public)
      final isGuestAllowedRoute = state.matchedLocation.startsWith('/home') ||
          state.matchedLocation.startsWith('/product') ||
          state.matchedLocation.startsWith('/search') ||
          state.matchedLocation.startsWith('/category') ||
          state.matchedLocation.startsWith('/cart') ||
          state.matchedLocation.startsWith('/wishlist') ||
          state.matchedLocation.startsWith('/profile');

      // 1. Not logged in
      if (!isLoggedIn && !isAuthRoute && !isGuestAllowedRoute) {
        return '/login';
      }

      // 2. Logged in
      if (isLoggedIn) {
        // Seller trying to access buyer routes? Redirect to seller dashboard.
        if (userRole == 'seller' && !state.matchedLocation.startsWith('/seller')) {
          return '/seller/dashboard';
        }
        // Buyer trying to access seller routes? Redirect to buyer home.
        if (userRole == 'customer' && state.matchedLocation.startsWith('/seller')) {
          return '/home';
        }
        // Logged in and trying to access auth routes -> go to appropriate home
        if (isAuthRoute) {
          return userRole == 'seller' ? '/seller/dashboard' : '/home';
        }
      }

      return null;
    },
    routes: [
      // AUTH ROUTES (Outside any ShellRoute)
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/addresses', builder: (context, state) => const AddressListScreen()),
      GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
      GoRoute(path: '/verify-phone', builder: (context, state) => const PhoneVerificationScreen()),
      GoRoute(
        path: '/product/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return ProductDetailScreen(productId: id);
        },
      ),
      GoRoute(path: '/checkout', builder: (context, state) => const CheckoutScreen()),
      GoRoute(
        path: '/order-confirmation/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return OrderConfirmationScreen(orderId: id);
        },
      ),
      GoRoute(
        path: '/search-results',
        builder: (context, state) {
          final query = state.uri.queryParameters['q'] ?? '';
          return SearchResultsScreen(query: query);
        },
      ),
      // In your routerProvider, inside the buyer ShellRoute routes list add:
GoRoute(
  path: '/orders',
  builder: (context, state) => const OrdersListScreen(),
),
GoRoute(
  path: '/orders/:id',
  builder: (context, state) {
    final id = int.parse(state.pathParameters['id']!);
    return OrderDetailScreen(orderId: id);
  },
),

      // BUYER SHELL ROUTE (with bottom nav bar)
      ShellRoute(
        builder: (context, state, child) {
          int getCurrentIndex() {
            final location = state.matchedLocation;
            if (location.startsWith('/home')) return 0;
            if (location.startsWith('/search')) return 1;
            if (location.startsWith('/cart')) return 2;
            if (location.startsWith('/wishlist')) return 3;
            if (location.startsWith('/profile')) return 4;
            return 0;
          }
          return BottomNavBar(currentIndex: getCurrentIndex(), child: child);
        },
        routes: [
          GoRoute(path: '/edit-profile', builder: (context, state) => const EditProfileScreen()),
          GoRoute(path: '/change-password', builder: (context, state) => const ChangePasswordScreen()),
          GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
          GoRoute(path: '/search', builder: (context, state) => const SearchScreen()),
          GoRoute(path: '/cart', builder: (context, state) => const CartScreen()),
          GoRoute(path: '/wishlist', builder: (context, state) => const WishlistScreen()),
          GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
          GoRoute(path: '/products', builder: (context, state) => const ProductListScreen()),
          GoRoute(
            path: '/flash-sale/:id',
            name: 'flashSaleProducts',
            builder: (context, state) {
              final flashSale = state.extra as FlashSale;
              return FlashSaleProductsScreen(flashSale: flashSale);
            },
          ),
          GoRoute(
            path: '/category/:slug',
            builder: (context, state) {
              final slug = state.pathParameters['slug']!;
              return ProductListScreen(categorySlug: slug);
            },
          ),
          GoRoute(
            path: '/collection/featured',
            name: 'featuredCollection',
            builder: (context, state) => const CollectionProductsScreen(collectionType: CollectionType.featured),
          ),
          GoRoute(
            path: '/collection/new-arrivals',
            name: 'newArrivalsCollection',
            builder: (context, state) => const CollectionProductsScreen(collectionType: CollectionType.newArrivals),
          ),
          GoRoute(
            path: '/collection/best-sellers',
            name: 'bestSellersCollection',
            builder: (context, state) => const CollectionProductsScreen(collectionType: CollectionType.bestSellers),
          ),
        ],
      ),

      // SELLER SHELL ROUTE (with its own bottom navigation)
      ShellRoute(
        builder: (context, state, child) {
          int getSellerCurrentIndex() {
            final location = state.matchedLocation;
            if (location.startsWith('/seller/dashboard')) return 0;
            if (location.startsWith('/seller/products')) return 1;
            if (location.startsWith('/seller/orders')) return 2;
            if (location.startsWith('/seller/wallet')) return 3;
            if (location.startsWith('/seller/settings')) return 4;
            return 0;
          }
          return SellerHomeScreen(currentIndex: getSellerCurrentIndex(), child: child);
        },
        routes: [
          GoRoute(
            path: '/seller/dashboard',
            builder: (context, state) => const SellerDashboardScreen(),
          ),
          // Placeholder routes for future phases
      GoRoute(
  path: '/seller/products',
  builder: (context, state) => const SellerProductListScreen(),
),
GoRoute(
  path: '/seller/products/add',
  builder: (context, state) => const SellerProductFormScreen(),
),
GoRoute(
  path: '/seller/products/:id/edit',
  builder: (context, state) {
    final id = int.parse(state.pathParameters['id']!);
    // You need to fetch product by id or pass as extra. Simpler: pass product as extra from list.
    // We'll modify product card to push with extra.
    // For now, we'll fetch inside form? Better to pass product via extra.
    // Let's adjust: In product card, onEdit: () => context.push('/seller/products/${product.id}/edit', extra: product)
    // Then here:
    final product = state.extra as Product?;
    return SellerProductFormScreen(product: product);
  },
),
      // Inside seller ShellRoute, replace existing routes with:
GoRoute(
  path: '/seller/orders',
  builder: (context, state) => const SellerOrderListScreen(),
),
GoRoute(
  path: '/seller/orders/:id',
  builder: (context, state) {
    final group = state.extra as SellerOrderGroup;
    return SellerOrderDetailScreen(group: group);
  },
),
GoRoute(
  path: '/seller/returns',
  builder: (context, state) => const SellerReturnListScreen(),
),
GoRoute(
  path: '/seller/inventory',
  builder: (context, state) => const SellerInventoryScreen(),
),
    // Inside seller ShellRoute routes list, add:
GoRoute(
  path: '/seller/wallet',
  builder: (context, state) => const SellerWalletScreen(),
),
GoRoute(
  path: '/seller/wallet/withdraw',
  builder: (context, state) => const SellerWithdrawalScreen(),
),
GoRoute(
  path: '/seller/discounts',
  builder: (context, state) => const SellerDiscountListScreen(),
),
GoRoute(
  path: '/seller/discounts/add',
  builder: (context, state) => const SellerDiscountFormScreen(),
),
GoRoute(
  path: '/seller/discounts/:id/edit',
  builder: (context, state) {
    final discount = state.extra as Map<String, dynamic>;
    return SellerDiscountFormScreen(discount: discount);
  },
),
GoRoute(
  path: '/seller/flash-sales',
  builder: (context, state) => const SellerFlashSaleListScreen(),
),
GoRoute(
  path: '/seller/flash-sales/:id/participate',
  builder: (context, state) {
    final flashSale = state.extra as Map<String, dynamic>;
    return SellerFlashSaleParticipateScreen(flashSale: flashSale);
  },
),
GoRoute(
  path: '/seller/settings',
  builder: (context, state) => const SellerSettingsScreen(),
),
        ],
      ),
    ],
  );
});