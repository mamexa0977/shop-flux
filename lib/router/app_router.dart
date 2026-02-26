 
import 'package:ecom_frontend/presentation/features/product/screens/product_detail_screen.dart';
import 'package:ecom_frontend/presentation/features/product/screens/product_list_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/enums/collection_type.dart';
import '../data/models/flash_sale.dart';
import '../presentation/collection/collection_products_screen.dart';
import '../presentation/features/home/widgets/flash_sale_products_screen.dart';
import '../providers/auth_state_provider.dart';

// Import your screens
import '../presentation/features/auth/screens/login_screen.dart';
import '../presentation/features/auth/screens/register_screen.dart';
import '../presentation/features/auth/screens/phone_verification_screen.dart';
import '../presentation/features/home/screens/home_screen.dart';
import '../presentation/features/cart/screens/cart_screen.dart';
import '../presentation/features/search/screens/search_screen.dart';
import '../presentation/features/wishlist/screens/wishlist_screen.dart';
import '../presentation/features/auth/screens/profile_screen.dart';
import '../presentation/features/auth/screens/edit_profile_screen.dart';
import '../presentation/features/auth/screens/change_password_screen.dart';

// Import the BottomNavBar widget (Ensure this widget ONLY contains the Scaffold + BottomNavigationBar, NOT the body logic)
import '../presentation/common_widgets/bottom_nav_bar.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // Watch auth state to trigger redirects when login/logout happens
  final authState = ref.watch(authStateProvider);
  final isLoggedIn = authState != null;

  return GoRouter(
    initialLocation:
        '/home', // Try starting at home, the redirect will kick us out if needed
    debugLogDiagnostics: true, // Helps us see what's happening in console
redirect: (context, state) {
  final isAuthRoute =
      state.matchedLocation.startsWith('/login') ||
      state.matchedLocation.startsWith('/register') ||
      state.matchedLocation.startsWith('/verify');

  // Define routes that GUESTS are allowed to see
  final isGuestAllowedRoute = 
      state.matchedLocation.startsWith('/home') || 
      state.matchedLocation.startsWith('/product') ||
      state.matchedLocation.startsWith('/search') ||
      state.matchedLocation.startsWith('/category')  ||
      state.matchedLocation.startsWith('/cart') ||      // ADDED
      state.matchedLocation.startsWith('/wishlist') ||  // ADDED
      state.matchedLocation.startsWith('/profile');

  // 1. If NOT logged in AND trying to access a restricted area (like Profile or Cart)
  // Send them to login ONLY if it's not a guest-friendly route.
  if (!isLoggedIn && !isAuthRoute && !isGuestAllowedRoute) {
    return '/login';
  }

  // 2. If Logged in and trying to go to Auth pages -> Send to Home
  if (isLoggedIn && isAuthRoute) {
    return '/home';
  }

  return null; // No redirect needed
},
  routes: [
      // AUTH ROUTES (Outside the Bottom Nav Bar)
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/verify-phone',
        builder: (context, state) => const PhoneVerificationScreen(),
      ),
          GoRoute(
  path: '/product/:id',
  builder: (context, state) {
    final id = int.parse(state.pathParameters['id']!);
    return ProductDetailScreen(productId: id);
  },
),
      // MAIN APP ROUTES (Inside the Bottom Nav Bar)
      // This ShellRoute keeps the BottomNavBar valid for all children
      ShellRoute(
        builder: (context, state, child) {
          // We need to pass the current index to the BottomNavBar based on location
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
          GoRoute(
            path: '/edit-profile',
            builder: (context, state) => const EditProfileScreen(),
          ),
          GoRoute(
            path: '/change-password',
            builder: (context, state) => const ChangePasswordScreen(),
          ),
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/search',
            builder: (context, state) => const SearchScreen(),
          ),
          GoRoute(
            path: '/cart',
            builder: (context, state) => const CartScreen(),
          ),
          GoRoute(
            path: '/wishlist',
            builder: (context, state) => const WishlistScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
  path: '/products',
  builder: (context, state) => const ProductListScreen(), // categorySlug = null
),
GoRoute(
  path: '/flash-sale/:id',
  name: 'flashSaleProducts',
  builder: (context, state) {
    final flashSale = state.extra as FlashSale; // retrieve passed object
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
// In your router configuration
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
    ],
  );
});
