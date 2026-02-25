// import 'package:ecom_frontend/core/constants/api_endpoints.dart';
// import 'package:ecom_frontend/providers/auth_state_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import '../../../common_widgets/guest_prompt_view.dart';
// import '../../../common_widgets/loading_indicator.dart';

// class ProfileScreen extends ConsumerWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // 1. Just watch the user directly from the Global Auth State
//     final user = ref.watch(authStateProvider);
//     final authNotifier = ref.read(authStateProvider.notifier);
//     final baseurl= ApiEndpoints.baseUrl;

//     // If user is null (shouldn't happen if guarded), show loading or redirect
//    if (user == null) {
//       return const Scaffold(
//         body: GuestPromptView(title: 'Profile', icon: Icons.person),
//       );
//     }
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.edit),
//             onPressed: () => context.push('/edit-profile'),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           children: [
//             CircleAvatar(
//               radius: 50,
//               backgroundImage: user.profileImage != null
//                   ? NetworkImage('$baseurl/uploads/profiles/${user.profileImage}')
//                   : null,
//               child: user.profileImage == null ? const Icon(Icons.person, size: 50) : null,
//             ),
//             const SizedBox(height: 16),

//             Text(user.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//             Text(user.phone, style: const TextStyle(fontSize: 16, color: Colors.grey)),

//             if (user.role == 'seller') ...[
//               const Divider(height: 32),
//               _buildInfoRow('Business Name', user.businessName),
//               _buildInfoRow('Business Reg Number', user.businessRegNumber),
//               _buildInfoRow('Business Address', user.businessAddress),
//               _buildInfoRow('Business Phone', user.businessPhone),
//               _buildInfoRow('Bank', user.bankName),
//               _buildInfoRow('Account Name', user.bankAccountName),
//               _buildInfoRow('Account Number', user.bankAccountNumber),
//               _buildInfoRow('Mobile Money', user.mobileMoneyNumber),
//               _buildInfoRow('Seller Status', user.sellerStatus),
//             ],
//             const SizedBox(height: 24),
//             ListTile(
//               leading: const Icon(Icons.lock),
//               title: const Text('Change Password'),
//               onTap: () => context.push('/change-password'),
//             ),
//             ListTile(
//               leading: const Icon(Icons.logout),
//               title: const Text('Logout'),
//               onTap: () async {
//                 await authNotifier.logout();
//                 if (context.mounted) context.go('/login');
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(String label, String? value) {
//     if (value == null || value.isEmpty) return const SizedBox();
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(width: 120, child: Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold))),
//           Expanded(child: Text(value)),
//         ],
//       ),
//     );
//   }
// }
import 'package:ecom_frontend/core/constants/api_endpoints.dart';
import 'package:ecom_frontend/providers/auth_state_provider.dart';
import 'package:ecom_frontend/providers/wishlist_providers.dart'; // for wishlist count
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../common_widgets/guest_prompt_view.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider);
    final authNotifier = ref.read(authStateProvider.notifier);
    final wishlistAsync = ref.watch(wishlistProvider); // for wishlist count
    final baseurl = ApiEndpoints.baseUrl;

    if (user == null) {
      return const Scaffold(
        body: GuestPromptView(title: 'Profile', icon: Icons.person),
      );
    }

    // Static/dummy data for demonstration – replace with real providers later
    final int orderCount = 12; // placeholder
    final int reviewCount = 8; // placeholder
    final int wishlistCount = wishlistAsync.value?.length ?? 0;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ----- Header with cover and profile -----
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            stretch: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Cover image (gradient)
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.green.shade800, Colors.green.shade400],
                      ),
                    ),
                  ),
                  // Profile picture and edit button
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              user.profileImage != null
                                  ? NetworkImage(
                                    '$baseurl/uploads/profiles/${user.profileImage}',
                                  )
                                  : null,
                          child:
                              user.profileImage == null
                                  ? const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.green,
                                  )
                                  : null,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(blurRadius: 4, color: Colors.black26),
                                ],
                              ),
                            ),
                            Text(
                              user.phone,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Edit button top right
                  Positioned(
                    top: 40,
                    right: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.9),
                      child: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.green),
                        onPressed: () => context.push('/edit-profile'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ----- Stats Cards -----
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  _buildStatCard(
                    context,
                    label: 'Orders',
                    value: orderCount.toString(),
                    icon: Icons.shopping_bag,
                    color: Colors.blue,
                    onTap: () => context.push('/orders'), // placeholder route
                  ),
                  const SizedBox(width: 12),
                  _buildStatCard(
                    context,
                    label: 'Wishlist',
                    value: wishlistCount.toString(),
                    icon: Icons.favorite,
                    color: Colors.red,
                    onTap: () => context.push('/wishlist'),
                  ),
                  const SizedBox(width: 12),
                  _buildStatCard(
                    context,
                    label: 'Reviews',
                    value: reviewCount.toString(),
                    icon: Icons.star,
                    color: Colors.amber,
                    onTap: () => context.push('/reviews'), // placeholder
                  ),
                ],
              ),
            ),
          ),

          // ----- Quick Actions Grid -----
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quick Actions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    children: [
                      _buildActionButton(
                        context,
                        Icons.shopping_bag,
                        'Orders',
                        () => context.push('/orders'),
                      ),
                      _buildActionButton(
                        context,
                        Icons.favorite,
                        'Wishlist',
                        () => context.push('/wishlist'),
                      ),
                      _buildActionButton(
                        context,
                        Icons.location_on,
                        'Addresses',
                        () => context.push('/addresses'),
                      ),
                      _buildActionButton(
                        context,
                        Icons.payment,
                        'Payments',
                        () => context.push('/payments'),
                      ),
                      _buildActionButton(
                        context,
                        Icons.notifications,
                        'Notifications',
                        () => context.push('/notifications'),
                      ),
                      _buildActionButton(
                        context,
                        Icons.support_agent,
                        'Support',
                        () => context.push('/support'),
                      ),
                      _buildActionButton(
                        context,
                        Icons.settings,
                        'Settings',
                        () => context.push('/settings'),
                      ),
                      _buildActionButton(
                        context,
                        Icons.info,
                        'About',
                        () => context.push('/about'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ----- Seller Information (if seller) -----
          if (user.role == 'seller') ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.store, color: Colors.green[700]),
                            const SizedBox(width: 8),
                            const Text(
                              'Seller Information',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 24),
                        _buildInfoRow('Business Name', user.businessName),
                        _buildInfoRow('Reg Number', user.businessRegNumber),
                        _buildInfoRow('Business Address', user.businessAddress),
                        _buildInfoRow('Business Phone', user.businessPhone),
                        _buildInfoRow('Bank', user.bankName),
                        _buildInfoRow('Account Name', user.bankAccountName),
                        _buildInfoRow('Account Number', user.bankAccountNumber),
                        _buildInfoRow('Mobile Money', user.mobileMoneyNumber),
                        _buildInfoRow('Status', user.sellerStatus),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],

          // ----- Account Settings -----
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.lock_outline,
                        color: Colors.blue,
                      ),
                      title: const Text('Change Password'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => context.push('/change-password'),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text('Logout'),
                      onTap: () async {
                        await authNotifier.logout();
                        if (context.mounted) context.go('/login');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom padding
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  // Helper: stat card
  Widget _buildStatCard(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper: quick action button
  Widget _buildActionButton(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.green.shade50,
            child: Icon(icon, color: Colors.green[700], size: 22),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 11),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // Helper: info row (unchanged but you can keep it)
  Widget _buildInfoRow(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
