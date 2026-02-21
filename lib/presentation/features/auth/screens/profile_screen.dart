import 'package:ecom_frontend/core/constants/api_endpoints.dart';
import 'package:ecom_frontend/providers/auth_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../common_widgets/guest_prompt_view.dart';
import '../../../common_widgets/loading_indicator.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Just watch the user directly from the Global Auth State
    final user = ref.watch(authStateProvider);
    final authNotifier = ref.read(authStateProvider.notifier);
    final baseurl= ApiEndpoints.baseUrl;

    // If user is null (shouldn't happen if guarded), show loading or redirect
   if (user == null) {
      return const Scaffold(
        body: GuestPromptView(title: 'Profile', icon: Icons.person),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/edit-profile'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: user.profileImage != null
                  ? NetworkImage('$baseurl/uploads/profiles/${user.profileImage}')
                  : null,
              child: user.profileImage == null ? const Icon(Icons.person, size: 50) : null,
            ),
            const SizedBox(height: 16),

            Text(user.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(user.phone, style: const TextStyle(fontSize: 16, color: Colors.grey)),
            
            if (user.role == 'seller') ...[
              const Divider(height: 32),
              _buildInfoRow('Business Name', user.businessName),
              _buildInfoRow('Business Reg Number', user.businessRegNumber),
              _buildInfoRow('Business Address', user.businessAddress),
              _buildInfoRow('Business Phone', user.businessPhone),
              _buildInfoRow('Bank', user.bankName),
              _buildInfoRow('Account Name', user.bankAccountName),
              _buildInfoRow('Account Number', user.bankAccountNumber),
              _buildInfoRow('Mobile Money', user.mobileMoneyNumber),
              _buildInfoRow('Seller Status', user.sellerStatus),
            ],
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Change Password'),
              onTap: () => context.push('/change-password'),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await authNotifier.logout();
                if (context.mounted) context.go('/login');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 120, child: Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}