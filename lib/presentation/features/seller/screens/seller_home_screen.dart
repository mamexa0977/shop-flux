import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../providers/auth_state_provider.dart';

class SellerHomeScreen extends ConsumerStatefulWidget {
  final int currentIndex;
  final Widget child;

  const SellerHomeScreen({
    super.key,
    required this.currentIndex,
    required this.child,
  });

  @override
  ConsumerState<SellerHomeScreen> createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends ConsumerState<SellerHomeScreen> {
  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        context.go('/seller/dashboard');
        break;
      case 1:
        context.go('/seller/products');
        break;
      case 2:
        context.go('/seller/orders');
        break;
      case 3:
        context.go('/seller/wallet');
        break;
      case 4:
        context.go('/seller/settings');
        break;
    }
  }

  void _openDrawerItem(String route) {
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Panel'),
        backgroundColor: const Color(0xFFFFFAD3),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFFFFAD3)),
              child: Text('Seller Menu', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () => _openDrawerItem('/seller/dashboard'),
            ),
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text('Products'),
              onTap: () => _openDrawerItem('/seller/products'),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Orders'),
              onTap: () => _openDrawerItem('/seller/orders'),
            ),
            ListTile(
              leading: const Icon(Icons.assignment_return),
              title: const Text('Returns'),
              onTap: () => _openDrawerItem('/seller/returns'),
            ),
            ListTile(
              leading: const Icon(Icons.inventory_2),
              title: const Text('Inventory'),
              onTap: () => _openDrawerItem('/seller/inventory'),
            ),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text('Wallet'),
              onTap: () => _openDrawerItem('/seller/wallet'),
            ),
            ListTile(
              leading: const Icon(Icons.local_offer),
              title: const Text('Discounts'),
              onTap: () => _openDrawerItem('/seller/discounts'),
            ),
            ListTile(
              leading: const Icon(Icons.flash_on),
              title: const Text('Flash Sales'),
              onTap: () => _openDrawerItem('/seller/flash-sales'),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => _openDrawerItem('/seller/settings'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                // Implement logout logic (clear token, navigate to login)
                // You already have logout in authStateProvider
                ref.read(authStateProvider.notifier).logout();
                context.go('/login');
              },
            ),
          ],
        ),
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Products'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}