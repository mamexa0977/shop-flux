 
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

      // 1. If NOT logged in and trying to go inside -> Send to Login
      if (!isLoggedIn && !isAuthRoute) {
        return '/login';
      }

      // 2. If Logged in and trying to go to Login -> Send to Home
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
        ],
      ),
    ],
  );
});
